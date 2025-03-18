from __future__ import division
from scipy.stats import norm
import pandas as pd
import numpy as np
from common import compare


def get_passed_failed_classification_performance(
    y_true, y_pred, y_std, rule, y_threshold, certain_threshold=0.95, margin_range=0.0
):
    data_df = pd.DataFrame(
        {
            "y_pred": y_pred.copy().flatten(),
            "y_true": y_true.copy().flatten(),
        }
    )
    data_df["passed"] = compare(data_df["y_true"], rule, y_threshold)
    data_df["failed"] = ~compare(data_df["y_true"], rule, y_threshold)
    data_df["predict_passed_by_single"] = compare(data_df["y_pred"], rule, y_threshold)
    data_df["predict_failed_by_single"] = ~compare(data_df["y_pred"], rule, y_threshold)
    if rule == "greaterThan":
        inBoundaryMargin = (data_df["y_pred"] <= y_threshold + margin_range) & (
            data_df["y_pred"] > y_threshold
        )
    else:
        inBoundaryMargin = (data_df["y_pred"] >= y_threshold - margin_range) & (
            data_df["y_pred"] < y_threshold
        )
    data_df["predict_passed_by_single"][inBoundaryMargin] = False
    data_df["predict_failed_by_single"][inBoundaryMargin] = True

    # print("y_true")
    # print(y_true.sum())
    # print("y_pred")
    # print(y_pred.sum())
    # print("data_df")
    # print(data_df.shape[0])
    # print("data_df passed")
    # print(data_df[data_df["passed"]].shape[0])
    # print("data_df failed")
    # print(data_df[data_df["failed"]].shape[0])
    # print("failed")
    # print(data_df[data_df["failed"]])
    # print("predict_failed_by_single")
    # print(data_df[data_df["predict_failed_by_single"]])

    def calculate_metrics(tp, fp, tn, fn):
        ap = tp + fn
        an = fp + tn
        pp = tp + fp
        pn = fn + tn

        true_positive_rate = tp / ap
        true_negative_rate = tn / an
        false_positive_rate = fp / an
        false_negative_rate = fn / ap
        false_discovery_rate = fp / pp
        positive_predictive_value = tp / pp
        negative_predictive_value = tn / pn

        ppv = positive_predictive_value
        npv = negative_predictive_value

        tpr = true_positive_rate
        fpr = false_positive_rate
        tnr = true_negative_rate
        fnr = false_negative_rate

        accuracy = (tp + tn) / (ap + an)
        balanced_accuracy = (tpr + tnr) / 2
        f1_score = (2 * ppv * tpr) / (ppv + tpr)

        if np.isnan(f1_score):
            f1_score = 0

        return {
            "true_positive": float(tp),
            "false_positive": float(fp),
            "true_negative": float(tn),
            "false_negative": float(fn),
            "accuracy": float(accuracy),
            "balanced_accuracy": float(balanced_accuracy),
            "f1_score": float(f1_score),
            "true_positive_rate": float(tpr),
            "true_negative_rate": float(tnr),
            "positive_predictive_value": float(ppv),
            "negative_predictive_value": float(npv),
        }

    def single_value_evaluate():
        pp = data_df["predict_passed_by_single"].sum()
        pn = data_df["predict_failed_by_single"].sum()
        ap = data_df["passed"].sum()
        an = data_df["failed"].sum()

        tp = (data_df["passed"] & data_df["predict_passed_by_single"]).sum()
        fp = pp - tp
        tn = (data_df["failed"] & data_df["predict_failed_by_single"]).sum()
        fn = pn - tn

        # print("SINGLE VALUE EVALUATION")
        # print("tp: {}".format(tp))
        # print("fp: {}".format(fp))
        # print("tn: {}".format(tn))
        # print("fn: {}".format(fn))
        # print("pp: {}".format(pp))
        # print("pn: {}".format(pn))
        # print("ap: {}".format(ap))
        # print("an: {}".format(an))

        return calculate_metrics(tp, fp, tn, fn)

    if y_std is not None:
        data_df["y_std"] = y_std.copy().flatten()

        cdf = norm.cdf(y_threshold, loc=data_df["y_pred"], scale=data_df["y_std"])
        data_df["passed_prob"] = 1 - cdf if rule == "greaterThan" else cdf
        data_df["failed_prob"] = 1 - data_df["passed_prob"]

        data_df["predict_passed_by_prob"] = data_df["passed_prob"] > certain_threshold
        data_df["predict_failed_by_prob"] = data_df["failed_prob"] > certain_threshold
        data_df["predict_uncertain_by_prob"] = (
            data_df["predict_passed_by_prob"] == 0
        ) & (data_df["predict_failed_by_prob"] == 0)

        def prob_evalulate():
            pp = data_df["predict_passed_by_prob"].sum()
            pn = (
                data_df["predict_failed_by_prob"].sum()
                + data_df["predict_uncertain_by_prob"].sum()
            )
            ap = data_df["passed"].sum()
            an = data_df["failed"].sum()

            tp = (data_df["passed"] & data_df["predict_passed_by_prob"]).sum()
            fp = pp - tp
            tn = (
                data_df["failed"]
                & (
                    data_df["predict_failed_by_prob"]
                    | data_df["predict_uncertain_by_prob"]
                )
            ).sum()
            fn = pn - tn

            # print("PROB EVALUATION")
            # print("tp: {}".format(tp))
            # print("fp: {}".format(fp))
            # print("tn: {}".format(tn))
            # print("fn: {}".format(fn))
            # print("pp: {}".format(pp))
            # print("pn: {}".format(pn))
            # print("ap: {}".format(ap))
            # print("an: {}".format(an))

            return calculate_metrics(tp, fp, tn, fn)

        return {
            "prob": prob_evalulate(),
            "single": single_value_evaluate(),
        }

    return {"single": single_value_evaluate()}
