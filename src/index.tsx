import { forwardRef, useRef, useImperativeHandle } from 'react';
import { StyleSheet } from 'react-native';
import SignOnGlassViewNativeComponent, {
  Commands as SignOnGlassViewCommands,
} from './SignOnGlassViewNativeComponent';
interface SignOnGlassViewProps {
  style?: object;
  color?: string;
  pencilWeight?: number;
  handleDrawingStarted?: () => void;
  clear?: () => void;
  expose?: () => Promise<string | null>;
}

const SignOnGlassView = forwardRef<SignOnGlassViewProps, any>(
  ({ style, color, pencilWeight, handleDrawingStarted, ...rest }, ref) => {
    const nativeRef = useRef(null);

    useImperativeHandle(
      ref,
      () => ({
        clear: () => {
          if (nativeRef.current) {
            SignOnGlassViewCommands.clearSignature(nativeRef.current);
          }
        },
        expose: async () => {
          if (nativeRef.current) {
            // Return a new promise
            return SignOnGlassViewCommands.exposeSignature(nativeRef.current);
          }
          return null;
        },
      }),
      [nativeRef]
    );

    // const handleSignatureExposed = (event: any) => {
    //   const signature = event.nativeEvent.signature || '';
    //   if (signaturePromiseRef.current) {
    //     signaturePromiseRef.current.resolve(signature);
    //     signaturePromiseRef.current = null;
    //   }
    // };

    return (
      <SignOnGlassViewNativeComponent
        ref={nativeRef}
        style={[styles.canvas, style]}
        color={color}
        pencilWeight={pencilWeight}
        onDrawingStarted={() => {
          console.log('drawing started');
          handleDrawingStarted?.();
        }}
        // onSignatureExposed={handleSignatureExposed}
        {...rest}
      />
    );
  }
);

const styles = StyleSheet.create({
  canvas: {
    width: '100%',
    height: 200,
    backgroundColor: '#F5FCFF',
  },
});

export default SignOnGlassView;
