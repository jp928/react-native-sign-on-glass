export default {
  name: 'SignOnGlassView',
  // propTypes: {
  //   color?: String;
  //   pencilWeight?: WithDefault<Int32, 2>;
  //   onSignatureExposed?: DirectEventHandler<SignatureExposedEvent>;
  //   onDrawingStarted?: DirectEventHandler<{}>;
  // },
  commands: {
    clearSignature: {
      name: 'clearSignature',
    },
    exposeSignature: {
      name: 'exposeSignature',
    },
  },
};
