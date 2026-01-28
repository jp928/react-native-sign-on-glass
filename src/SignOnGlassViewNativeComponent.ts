import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type { HostComponent, ViewProps } from 'react-native';
import type {
  DirectEventHandler,
  Int32,
} from 'react-native/Libraries/Types/CodegenTypes';
import type { WithDefault } from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeCommands from 'react-native/Libraries/Utilities/codegenNativeCommands';

interface SignatureExposedEvent {
  signature: string;
}

interface NativeProps extends ViewProps {
  color?: string;
  pencilWeight?: WithDefault<Int32, 2>;
  onSignatureExposed?: DirectEventHandler<SignatureExposedEvent>;
  onDrawingStarted?: DirectEventHandler<{}>;
}
export type SignOnGlassViewNativeComponentType =
  React.ComponentType<NativeProps>;

export interface NativeCommands {
  clearSignature: (
    viewRef: React.ElementRef<SignOnGlassViewNativeComponentType>
  ) => void;
  exposeSignature: (
    viewRef: React.ElementRef<SignOnGlassViewNativeComponentType>
  ) => string | null;
}

export const Commands: NativeCommands = codegenNativeCommands<NativeCommands>({
  supportedCommands: ['clearSignature', 'exposeSignature'],
});

export default codegenNativeComponent<NativeProps>(
  'SignOnGlassView'
) as HostComponent<NativeProps>;
