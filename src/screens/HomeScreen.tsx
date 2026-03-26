/**
 * HomeScreen.tsx
 * Pantalla principal de AppResum.
 * Muestra el punto de entrada para subir archivos.
 */
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>AppResum 📄</Text>
      <Text style={styles.subtitle}>Sube un archivo para resumirlo con IA</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#fff' },
  title: { fontSize: 28, fontWeight: 'bold', color: '#333' },
  subtitle: { fontSize: 16, color: '#888', marginTop: 8 },
});