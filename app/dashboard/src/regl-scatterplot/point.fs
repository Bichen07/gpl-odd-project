const FRAGMENT_SHADER = `
precision highp float;

uniform float antiAliasing;

varying vec4 color;
varying float finalPointSize;
varying float label;

float linearstep(float edge0, float edge1, float x) {
  return clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
}

// Signed distance function for an equilateral triangle pointing upward
float sdfTriangle(vec2 p) {
    const float sqrt3 = 1.7320508; // Approximate sqrt(3)

    // Define the triangle in a normalized space
    p.y -= 1.0 / sqrt3; // Shift triangle upwards
    p.x = abs(p.x); // Mirror x for symmetry

    // Compute the distance to the triangle edges
    float edge = sqrt3 * p.x + p.y - (2.0 / sqrt3);

    // Use max to get the inside-outside distance
    return max(edge, -p.y);
}

void main() {
  vec2 c = gl_PointCoord * 2.0 - 1.0;
  float sdf = 0.0;
  if (label == 1.0) {
    sdf = sdfTriangle(c * finalPointSize);
  }
  else if (label == 2.0) {
    sdf = max(abs(c.x), abs(c.y)) * finalPointSize;
  } else {
    sdf = length(c) * finalPointSize;
  }
  float alpha = linearstep(finalPointSize + antiAliasing, finalPointSize - antiAliasing, sdf);

  gl_FragColor = vec4(color.rgb, alpha * color.a);
}
`;

export default FRAGMENT_SHADER;
