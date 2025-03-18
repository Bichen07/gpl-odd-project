import os
import csv
import pandas as pd
import numpy as np
import json
import pickle
import time
import math
from sync.common import utils as sync_utils
from sync.common.constants import DATA_ROOT
from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error
from sklearn.model_selection import GridSearchCV, train_test_split
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from constants import FOLDER_PATH, MODEL_NAME, SCALER_NAME


class KNearestNeighbor():
    def __init__(self, data):
        self._read_dataset(data)

    def _read_dataset(self, data):
        headers = ['#', 'scenario', 'state', 'value_evaluation', 'timestamp', 'ego_position_x', 'ego_position_y', 'ego_speed', 'ego_acceleration', 'agent_relative_orientation', 'agent_relative_angular_velocity', 'agent_relative_velocity_x', 'agent_relative_velocity_y',
                   'agent_relative_position_x', 'agent_relative_position_y', 'agent_relative_position_x_next_1', 'agent_relative_position_y_next_1', 'agent_relative_position_x_next_2', 'agent_relative_position_y_next_2', 'ego_tag_trees', 'agent_tag_trees']
        print("[Feature Matcher] Loading matched samples from tag_tree_matcher...")
        dfs = []
        for i in data['category_data']:
            for v in i:
                dfs.append(v)
            train_df = pd.DataFrame(dfs, columns=headers)
        print("[Feature Matcher] All samples loaded")
        train_df = train_df.astype(float)
        X_train, y_train = self._transform_features(train_df)
        print("[Feature Matcher] Samples size: {}".format(len(X_train)))
        start = time.time()
        self._model = KNeighborsRegressor(n_neighbors=3)
        self._model.fit(X_train, y_train)
        end = time.time()
        duration = end - start
        print("[Feature Matcher] Training Time: {}".format(duration))
        file_path = os.path.join(FOLDER_PATH, MODEL_NAME)
        self._save_file(self._model, file_path)

    def _transform_features(self, df):
        df_clean = df.copy()

        to_keep = ['value_evaluation', 'ego_position_x', 'ego_position_y', 'ego_speed', 'ego_acceleration', 'agent_relative_orientation', 'agent_relative_angular_velocity', 'agent_relative_velocity_x', 'agent_relative_velocity_y',
                   'agent_relative_position_x', 'agent_relative_position_y', 'agent_relative_position_x_next_1', 'agent_relative_position_y_next_1', 'agent_relative_position_x_next_2', 'agent_relative_position_y_next_2']
        df_clean = df_clean[to_keep]
        df_clean = df_clean.dropna()

        x = df_clean.drop(labels='value_evaluation', axis=1)
        y = df_clean.value_evaluation

        scaler = MinMaxScaler().fit(x)
        x = scaler.transform(x)
        file_path = os.path.join(FOLDER_PATH, SCALER_NAME)
        self._save_file(scaler, file_path)
        return x, y

    def _save_file(self, file, filename):
        picklefile = open(filename, 'wb')
        pickle.dump(file, picklefile)
        picklefile.close()
