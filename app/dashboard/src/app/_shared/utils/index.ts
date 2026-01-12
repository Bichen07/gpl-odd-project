import chroma from "chroma-js";
import {
  ClusterInfo,
  generateColors,
} from "@/app/batch/[id]/_tabs/explore/redux/slices/batch";
import { ClusteringResult } from "../graphql/queries/clustering";
import { postDocument } from "../graphql/queries/documents";

export async function uploadImageElement(
  image: HTMLImageElement,
  name: string
) {
  // Create a canvas to draw the image
  const canvas = document.createElement("canvas");
  canvas.width = image.naturalWidth;
  canvas.height = image.naturalHeight;
  const ctx = canvas.getContext("2d");
  if (!ctx) throw new Error("Canvas 2D context not available");

  ctx.drawImage(image, 0, 0);

  // Convert canvas content to Blob
  canvas.toBlob(async (blob) => {
    if (!blob) {
      console.error("Failed to convert image to blob");
      return;
    }

    // Prepare FormData for upload
    const form = new FormData();
    form.append("file", blob, `${name}.png`);

    try {
      await postDocument(form); // your custom upload function
      console.log(`${name} uploaded`);
    } catch (err) {
      console.error("Upload failed", err);
    }
  }, "image/png"); // or "image/jpeg"
}

export const urlify = (str: string): string => {
  if (str.length === 0) {
    return "";
  }
  if (str[0] === " ") {
    return "%20" + urlify(str.slice(1));
  }
  return str[0] + urlify(str.slice(1));
};

export const safeIdleCallback = (cb: () => void) => {
  if (typeof window.requestIdleCallback === "function") {
    window.requestIdleCallback(cb);
  } else {
    setTimeout(cb, 10); // small delay to yield to UI thread
  }
};

export const extractImageBitmapFromCanvas = async (
  canvas: HTMLCanvasElement
): Promise<ImageBitmap | HTMLImageElement> => {
  const blob: Blob = await new Promise((resolve) =>
    canvas.toBlob((b) => resolve(b!), "image/png")
  );

  try {
    return await createImageBitmap(blob);
  } catch {
    // fallback for Safari or old browsers
    return await new Promise((resolve) => {
      const url = URL.createObjectURL(blob);
      const img = new Image();
      img.onload = () => {
        URL.revokeObjectURL(url);
        resolve(img);
      };
      img.src = url;
    });
  }
};
export function getOrCreateUserId() {
  let userId = localStorage.getItem("user_id");
  if (!userId) {
    userId = "user-" + crypto.randomUUID();
    localStorage.setItem("user_id", userId);
  }
  return userId;
}

export function toTitleSpaceCase(input: string): string {
  input = input.replace("Idling", "Parking");
  input = input.replace("CuttingIn", "Cut-in");

  // Convert snake_case to space case
  let spaced = input.replace(/_/g, " ");

  // Convert camelCase to space case (inserting space before uppercase letters)
  spaced = spaced.replace(/([a-z])([A-Z])/g, "$1 $2");

  // Capitalize the first letter of each word
  let result = spaced.replace(/\b\w/g, (char) => char.toUpperCase());
  result = result.replace("Cut-In", "Cut-in");
  return result;
}

export function loadImageAsync(src: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = "anonymous"; // Optional, needed if image is from another domain
    img.onload = () => resolve(img);
    img.onerror = (err) => reject(err);
    img.src = src;
  });
}

export function getBase64Image(img: HTMLImageElement) {
  const canvas = document.createElement("canvas");
  canvas.width = img.width;
  canvas.height = img.height;

  var ctx = canvas.getContext("2d");
  if (ctx == null) {
    return null;
  }
  ctx.drawImage(img, 0, 0);

  var dataURL = canvas.toDataURL("image/png");

  return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
}

export function imageToBlob(img: HTMLImageElement) {
  return new Promise((resolve) => {
    const canvas = document.createElement("canvas");
    canvas.width = img.width;
    canvas.height = img.height;

    var ctx = canvas.getContext("2d");
    if (ctx == null) {
      return null;
    }
    ctx.drawImage(img, 0, 0);
    canvas.toBlob((blob) => {
      resolve(blob);
    }, "image/png"); // or 'image/png'
  });
}

export async function getTextFromTxtFile(url: string) {
  try {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`HTTP error: ${response.status}`);

    const text = await response.text();
    return text;
  } catch (error) {
    console.error("Failed to load text file:", error);
    return null;
  }
}

export const noiseColor = chroma.brewer.Pastel2[7];
export const getClusterInfos = (results: ClusteringResult[]) => {
  const updated: ClusterInfo[] = [];
  for (const result of results ?? []) {
    if (result == null) {
      continue;
    }
    const clusters: ClusterInfo = {};

    for (const item of Object.values(result.data)) {
      if (item == null) {
        continue;
      }
      if (!(item.label in clusters)) {
        clusters[item.label] = {
          color: "",
          count: 0,
        };
      }
      clusters[item.label].count += 1;
    }
    let hasNoise = false;
    let uniqueClusterCount = Object.keys(clusters).length;
    if ("-1" in clusters) {
      uniqueClusterCount -= 1;
      hasNoise = true;
    }

    const palette = generateColors(uniqueClusterCount);

    const clusterLabels = Object.keys(clusters).sort();
    for (const [index, clusterLabel] of clusterLabels.entries()) {
      if (clusterLabel === "-1") {
        clusters[clusterLabel].color = noiseColor;
      } else {
        clusters[clusterLabel].color = palette[hasNoise ? index - 1 : index];
      }
    }
    updated.push(clusters);
  }
  return updated;
};
