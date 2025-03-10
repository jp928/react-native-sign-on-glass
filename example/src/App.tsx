import { useRef } from 'react';
import { Button, StyleSheet, View } from 'react-native';
import SignOnGlassView from 'react-native-sign-on-glass';

export default function App() {
  const ref = useRef<any>(null);
  // const [signature, setSignature] = useState<string>('');
  return (
    <View style={styles.container}>
      <SignOnGlassView ref={ref} color="#e3e3e3" style={styles.box} />
      <Button title="Clear" onPress={() => ref.current.clear()} />
      <Button
        title="Expose"
        onPress={() => {
          const base64 = ref.current.expose();
          console.log(base64);
          // setSignature(base64);
        }}
      />
      {/* <Text>{signature}</Text> */}
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
