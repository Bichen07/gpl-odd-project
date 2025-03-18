precision mediump float;

attribute vec2 a_Position;

// These are instanced attributes.
attribute vec2 a_Offset;
attribute vec3 a_Color;

uniform mat4 u_ViewProjection;
uniform float u_CameraScale;

varying vec3 v_Color;

void main() {
  gl_Position = u_ViewProjection * vec4(a_Position / u_CameraScale + a_Offset, 0.0, 1.0);

  v_Color = a_Color;
}
