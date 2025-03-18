from collections import OrderedDict
from safety_metrics.ttc import TimeToCollisionMetric
from safety_metrics.collision import CollisionMetric
from safety_metrics.rss_proper_response import RssPreventableChecker
from safety_metrics.jerk import JerkMetric
from safety_metrics.safety_metric_base import MetricBase


class Scoring:
    def __init__(self):
        self.metrics = [
            TimeToCollisionMetric(),
            CollisionMetric(),
            RssPreventableChecker()
            # JerkMetric(),
        ]  # type: list[MetricBase]

    def reset(self):
        for metric in self.metrics:
            metric.reset()

    def get_record(self):
        result = OrderedDict()
        for metric in self.metrics:
            record = metric.get_record()  # type: OrderedDict
            for key, value in record.items():
                result[key] = value
        return result

    def get_score(self):
        result = OrderedDict()
        for metric in self.metrics:
            score = metric.get_score()  # type: OrderedDict
            for key, value in score.items():
                result[key] = value
        return result
