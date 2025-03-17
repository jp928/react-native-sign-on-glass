This is a new [**React Native**](https://reactnative.dev) project, bootstrapped using [`@react-native-community/cli`](https://github.com/react-native-community/cli).

# Getting Started

```
yarn add react-native-sign-on-glass 
```
or 

```
npm install react-native-sign-on-glass
```

inside ios folder run

```
pod install
```

inside android folder run

```
./gradlew clean
```

# How to use

```
import SignOnGlassView from 'react-native-sign-on-glass';
<View style={styles.container}>
  <SignOnGlassView ref={ref} color="#e3e3e3" style={styles.box} />
  <Button title="Clear" onPress={() => ref.current.clear()} />
  <Button
    title="Expose"
    onPress={async () => {
      const base64 = await ref.current.expose();
      console.log(base64);
    }}
  />
</View>
```

## Imperative API

### `clear()`

Clear the signature canvas

### `expose()`

Asynchronous function which exposes signature as base64 string
