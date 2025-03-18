import argparse

from core import PushModule, PullModule, list_data_summary


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--push", help="push all data.", action="store_true")
    parser.add_argument("--pull", help="pull all data.", action="store_true")
    parser.add_argument("--filter",
                        metavar="KEY=VALUE",
                        nargs='+',
                        help="Filtering pulling data. "
                        "You can set a number of key-value pairs as Filter. "
                        "Multiple conditions (pairs) will do AND operation. "
                        "See available keys and examples in README.md")
    parser.add_argument("--list", help="display summary of local data.", action="store_true")
    args = parser.parse_args()
    return args


def parse_key_value_pairs(items: list):
    if not items:
        return {}
    return {k: v for k, v in map(lambda x: x.split('='), items)}


def main():
    print("\nPreparing...")
    args = parse_args()
    print("\targs =", args)

    if args.push:
        print("\nPushing...")
        push = PushModule()
        fail, pushed_count = push.pushing()
        if len(fail) > 0:
            print("{} data failed to push:\n".format(len(fail)))
            for obj, err in fail:
                print("{}: {}".format(obj, err))
        print("Done, pushed {} data.".format(pushed_count))

    if args.pull:
        print("\nPulling...")
        filters = parse_key_value_pairs(args.filter)
        pull = PullModule(filters)
        fail, pulled_count = pull.pulling()
        if len(fail) > 0:
            print("{} data failed to pull:\n".format(len(fail)))
            for obj, err in fail:
                print("{}: {}".format(obj, err))
        print("Done, pulled {} data.".format(pulled_count))

    if args.list:
        print("\nListing...")
        filters = parse_key_value_pairs(args.filter)
        summary = list_data_summary(filters)
        print("\tScenario file count:", len(summary["scenario_files"]))
        print("\tScenario data count:",
            sum(cnt for _, cnt in summary["scenario_files"]))
        print("\tObservation file count:", len(summary["observation_files"]))
        print("\tObservation data count:",
            sum(cnt for _, cnt in summary["observation_files"]))


if __name__ == '__main__':
    main()
