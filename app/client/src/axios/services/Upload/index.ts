import { AxiosProgressEvent, AxiosResponse } from "axios";
import http from "src/axios/http-common";

export type CreateNewUpload = (
  data: FormData,
  signal: AbortSignal,
  handleUploadProgress?: ((event: AxiosProgressEvent) => void) | undefined,
) => Promise<AxiosResponse<any, any>>;

const createNewUpload = (url: string): CreateNewUpload => {
  return (
    data: FormData,
    signal: AbortSignal,
    handleUploadProgress?: (event: AxiosProgressEvent) => void,
  ) => {
    return http.request({
      method: "post",
      url: url,
      data: data,
      signal: signal,
      onUploadProgress: (event) =>
        handleUploadProgress ? handleUploadProgress(event) : null,
    });
  };
};

const deleteMedia = (id: string) => {
  return http.delete(`/media/${id}`);
};
const createMedia = createNewUpload("/media");

const deleteOpenDrive = (id: string) => {
  return http.delete(`/openDrives/${id}`);
};
const createOpenDrive = createNewUpload("/openDrives");

const deleteOpenScenario = (id: string) => {
  return http.delete(`/openScenarios/${id}`);
};
const createOpenScenario = createNewUpload("/openScenarios");

const UploadService = {
  deleteMedia,
  createMedia,
  deleteOpenDrive,
  createOpenDrive,
  deleteOpenScenario,
  createOpenScenario,
};

export default UploadService;
