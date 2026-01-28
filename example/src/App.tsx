import { useRef, useState } from 'react';
import { Button, StyleSheet, Text, ScrollView } from 'react-native';
import SignOnGlassView from 'react-native-sign-on-glass';

export default function App() {
  const ref = useRef<any>(null);

  const [encoded, setEncoded] = useState();
  return (
    <ScrollView contentContainerStyle={styles.container}>
      <SignOnGlassView
        ref={ref}
        // color="#e3e3e3"
        style={styles.box}
        handleDrawingStarted={() => console.log('Drawing started')}
      />
      <Button title="Clear" onPress={() => ref.current.clear()} />
      <Button
        title="Expose!"
        onPress={async () => {
          const base64 = await ref.current.expose();
          setEncoded(base64);
        }}
      />
      <Text>{encoded}</Text>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 200,
    height: 200,
    marginVertical: 20,
    backgroundColor: 'red',
  },
});
