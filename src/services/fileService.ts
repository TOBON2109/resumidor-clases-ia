/**
 * fileService.ts
 * Servicio para captura y selección de archivos.
 * Soporta imágenes, videos, audios y documentos.
 */
import { launchImageLibrary, launchCamera } from 'react-native-image-picker';
import DocumentPicker from 'react-native-document-picker';  

// Seleccionar imagen o video desde galería
export const pickImageFromGallery = () => {
  return new Promise((resolve, reject) => {
    launchImageLibrary({ mediaType: 'mixed' }, (response) => {
      if (response.didCancel) resolve(null);
      else if (response.errorCode) reject(response.errorMessage);
      else resolve(response.assets?.[0]);
    });
  });
};

// Capturar foto o video con la cámara
export const captureFromCamera = () => {
  return new Promise((resolve, reject) => {
    launchCamera({ mediaType: 'mixed' }, (response) => {
      if (response.didCancel) resolve(null);
      else if (response.errorCode) reject(response.errorMessage);
      else resolve(response.assets?.[0]);
    });
  });
};

// Seleccionar documento (PDF, DOCX, TXT) con validación de tamaño
export const pickDocument = async () => {
  const result = await DocumentPicker.pickSingle({
    type: [
      DocumentPicker.types.pdf,
      DocumentPicker.types.docx,
      DocumentPicker.types.plainText,
    ],
  });
  const MAX_SIZE = 20 * 1024 * 1024; // 20MB
  if (result.size && result.size > MAX_SIZE) {
    throw new Error('El archivo no puede superar los 20MB');
  }
  return result;
};