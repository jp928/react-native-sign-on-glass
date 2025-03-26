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

    const signaturePromiseRef = useRef<{
      resolve: (value: string) => void;
      reject: (reason: any) => void;
    } | null>(null);

    useImperativeHandle(
      ref,
      () => ({
        clear: () => {
          if (nativeRef.current) {
            SignOnGlassViewCommands.clearSignature(nativeRef.current);
          }
        },
        expose: async () => {
          // Return a new promise
          return new Promise<string>((resolve, reject) => {
            if (nativeRef.current) {
              // Store the promise callbacks
              signaturePromiseRef.current = { resolve, reject };
              // Call the native command (this will trigger the event)
              SignOnGlassViewCommands.exposeSignature(nativeRef.current);
            } else {
              reject(new Error('Native view reference not available'));
            }
          });
        },
      }),
      [nativeRef]
    );

    const handleSignatureExposed = (event: any) => {
      const signature = event.nativeEvent.signature || '';
      if (signaturePromiseRef.current) {
        signaturePromiseRef.current.resolve(signature);
        signaturePromiseRef.current = null;
      }
    };

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
        onSignatureExposed={handleSignatureExposed}
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
