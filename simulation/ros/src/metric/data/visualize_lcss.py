import json
import numpy as np
import collections
import matplotlib.pyplot as plt

def read_data(file_name):
    dimensions = collections.OrderedDict(
        [
            ('x', True),
            ('y', True),
            ('z', False),
            ('yaw', False),
            ('speed cmd', False),
            ('actual speed', False)
        ])

    with open(file_name, 'r') as data_file:
        data = json.load(data_file)
        info = 'data load from {}\n'.format(file_name) + \
            'data format: {}\n'.format(data["data_format"]) + \
            'init timestamp: {:.3f}\n'.format(data["init_stamp"]) + \
            'sim data\n' + \
            'size: {}\n'.format(len(data['sim'])) + \
            'relative stamp from {:.3f} to {:.3f}\n' \
            ''.format(data['sim'][0][0] - data['init_stamp'], data['sim'][-1][0]
                      - data['init_stamp']) + \
            'real data\n' + \
            'size: {}\n'.format(len(data['real'])) + \
            'realative stamp from {:.3f} to {:.3f}\n' \
            ''.format(data['real'][0][0] - data['init_stamp'],
                      data['real'][-1][0] - data['init_stamp']) + \
            '=' * (37 + len(file_name)) + '\n\n'

        print(info)

    # remove timestamp
    for ego_from in ['sim', 'real']:
        data[ego_from] = np.array(data[ego_from])[:, 1:]

    for col, (key, chosen) in enumerate(dimensions.items()):
        #print('{}, {}, {}'.format(col, key, chosen))
        if key in data['data_format']:
            print('{:12}: {}'.format(key, chosen))
            if not chosen:
                for ego_from in ['sim', 'real']:
                    data[ego_from][:, col] = np.nan

    for ego_from in ['sim', 'real']:
        data[ego_from] = data[ego_from][:, ~np.all(np.isnan(data[ego_from]), axis = 0)]

    traj_list = [data['sim'], data['real']]

    fig, ax = plt.subplots()
    plot1 = ax.plot(
        traj_list[0][:, 0],
        traj_list[0][:, 1],
        'b',
        linewidth=2)
    plot2 = ax.plot(
        traj_list[1][:, 0],
        traj_list[1][:, 1],
        'r',
        linewidth=2)

    plt.show()


def main():
    data_name = 'recorded-traj-2021-07-19-10-36-32.json'
    read_data(data_name)


if __name__ == '__main__':
    main()
