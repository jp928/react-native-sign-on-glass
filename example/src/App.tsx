import { useRef } from 'react';
import { View, StyleSheet, Button } from 'react-native';
import SignOnGlassView from 'react-native-sign-on-glass';

export default function App() {
  const ref = useRef<any>(null);
  return (
    <View style={styles.container}>
      <SignOnGlassView ref={ref} color="#e3e3e3" style={styles.box} />
      <Button title="Clear" onPress={() => ref.current.clear()} />
      <Button
        title="Expose"
        onPress={() => console.log(ref.current.expose())}
      />
    </View>
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
  },
});
