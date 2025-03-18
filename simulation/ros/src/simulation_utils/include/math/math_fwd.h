#ifndef _MATH_FWD_H_
#define _MATH_FWD_H_

namespace math {

template<typename Scalar> class ColVector2d;
template<typename Scalar> class ColVector3d;
template<typename Scalar> class ColVector4d;
template<typename Scalar> class SpatialInertia;
template<typename Scalar> class SpatialTransform;
template<typename Scalar> class SpatialVector;
template<typename Scalar> class EpsilonPrecision;
template<typename FirstType, typename SecondType> struct Pair;
template<typename Id> class SegmentMap;
template<typename ValueType> class FiniteDifferenceEvaluator;

//class CubicSpline;
//class CubicSplineInterpolator;
class CatmullRomSplineInterpolator;
class CubicHermiteSplineInterpolator;
class CubicPolynomialSolution;
class CubicPolynomialSolver;
class EulerIntegrator;
class FrenetCoord;
class FrenetTransformer;
class FrenetVelocityTransformer;
class GenerateRandomIntValue;
class GenerateRandomRealValue;
class GenerateRandomVector;
class GenerateUniformDistributionRandomIntValue;
class GenerateUniformDistributionRandomRealValue;
class GenerateRandomQuaternion;
class EvalOrthogonalComplement;
class EaseInOutGenerator;
class QuadraticBezierCurve;
class QuadraticFunc;
class QuadraticLinearWeight;
class NullSpaceEvaluator;
class FullPivLuNullSpaceEvaluator;
class SvdNullSpaceEvaluator;
class ParametricCircle;
class PseudoinverseNullSpaceEvaluator;
class HouseholderQr;
class Integrator;
class Limiter;
class LinearSystem;
struct MatrixElement;
class MotionEquation;
class Segment;
class SpaceCurveFeatureEvaluator;
class TaylorSeries;

class ValidateObjectCollApprox;
class ValidateOptionalApprox;
class ValidatePositiveSemidefinite;
class VectorToPlaneRotationalAngleEvaluator;

class Vector3dCollTextParser;

} // namespace math {

#endif // #ifndef _MATH_FWD_H_
