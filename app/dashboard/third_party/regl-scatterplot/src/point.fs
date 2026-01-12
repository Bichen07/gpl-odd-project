const FRAGMENT_SHADER = `
precision highp float;

uniform float antiAliasing;

varying vec4 color;
varying float finalPointSize;
varying float label;

float sdRoundedX( in vec2 p, in float w, in float r )
{
    p = abs(p);
    return length(p-min(p.x+p.y,w)*0.5) - r;
}

float sdCircle(in vec2 p, in float r)
{
  return length(p) - r;
}

// float sdEquilateralTriangle( in vec2 p, in float r )
// {
//     const float k = sqrt(3.0);
//     p.x = abs(p.x) - r;
//     p.y = p.y + r/k;
//     if( p.x+k*p.y>0.0 ) p = vec2(p.x-k*p.y,-k*p.x-p.y)/2.0;
//     p.x -= clamp( p.x, -2.0*r, 0.0 );
//     return -length(p)*sign(p.y);
// }
float sdEquilateralTriangle(in vec2 p, in float r)
{
    const float k = sqrt(3.0);

    // Rotate 180°
    p = -p;

    // Rest of original
    p.x = abs(p.x) - r;
    p.y = p.y + r/k;
    if( p.x+k*p.y>0.0 )
        p = vec2(p.x-k*p.y, -k*p.x-p.y) / 2.0;
    p.x -= clamp(p.x, -2.0*r, 0.0);
    return -length(p) * sign(p.y);
}

float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

float sdStar(in vec2 p, in float r )
{
    const float k1x = 0.809016994; // cos(π/ 5) = ¼(√5+1)
    const float k2x = 0.309016994; // sin(π/10) = ¼(√5-1)
    const float k1y = 0.587785252; // sin(π/ 5) = ¼√(10-2√5)
    const float k2y = 0.951056516; // cos(π/10) = ¼√(10+2√5)
    const float k1z = 0.726542528; // tan(π/ 5) = √(5-2√5)
    const vec2  v1  = vec2( k1x,-k1y);
    const vec2  v2  = vec2(-k1x,-k1y);
    const vec2  v3  = vec2( k2x,-k2y);

    p.x = abs(p.x);
    p -= 2.0*max(dot(v1,p),0.0)*v1;
    p -= 2.0*max(dot(v2,p),0.0)*v2;
    p.x = abs(p.x);
    p.y -= r;
    return length(p-v3*clamp(dot(p,v3),0.0,k1z*r))
           * sign(p.y*v3.x-p.x*v3.y);
}


void main() {
  vec2 p = gl_PointCoord * 2.0 - 1.0;
  float d = 0.0;
  vec4 col = color;

  float shapeCount = 4.0;
  bool isHollow = label >= shapeCount;

  if (mod(label, shapeCount) == 0.0) {
    d = sdCircle(p, 1.0);
    if (isHollow && d < -0.5) {
      col = vec4(col.rgb, 0.0);
    }
  } else if (mod(label, shapeCount) == 1.0) {

    float w_norm = 2.0;
    float r_norm = 0.25;
    d = sdRoundedX(p, w_norm, r_norm);


    if (isHollow && d < -0.3) {
      col = vec4(col.rgb, 0.0);
    }
  } else if (mod(label, shapeCount) == 2.0) {
    // d = sdEquilateralTriangle(p, 0.9);

    float w_norm = 2.0;
    float r_norm = 0.25;
    d = sdRoundedX(p, w_norm, r_norm);


    if (isHollow && d < -0.3) {
      col = vec4(col.rgb, 0.0);
    }

    // d = sdStar(p, 1.0);
    // if (isHollow && d < -0.2) {
    //   col = vec4(col.rgb, 0.0);
    // }
  } else {
    d = sdBox(p, vec2(1.0, 1.0));
    if (isHollow && d < -0.5) {
      col = vec4(col.rgb, 0.0);
    }
  }

  // d = sdCircle(p, 1.0);

  float aa_norm = antiAliasing / finalPointSize;
  float alpha = smoothstep( aa_norm, -aa_norm, d );
  gl_FragColor = vec4(col.rgb, alpha * col.a);
}
`;

export default FRAGMENT_SHADER;
