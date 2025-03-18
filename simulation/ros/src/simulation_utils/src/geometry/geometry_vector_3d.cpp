#include <geometry_vector_3d.h>
#include <boost/numeric/conversion/cast.hpp>

namespace geometry {

// public func.

std::vector<Vector2d> Vector3d::ToVectorXys(
    const std::vector<Vector3d> &vector3ds)
{
    std::vector<Vector2d> outputs(vector3ds.size());
    std::transform(
        vector3ds.cbegin(),
        vector3ds.cend(),
        outputs.begin(),
        [](const Vector3d &vector3d)
        {return vector3d.ToVectorXy();});

    return outputs;
}

Vector3d::Vector3d()
    : Base(Base::Zero())
{
}

Vector3d::Vector3d(const double inputX, const double inputY, const double inputZ)
    : Base(inputX, inputY, inputZ)
{
}

Vector3d::Vector3d(const geometry_msgs::Vector3 &vector3)
    : Base(vector3.x, vector3.y, vector3.z)
{
}

Vector3d::Vector3d(const geometry_msgs::Point32 &point32)
    : Base(point32.x, point32.y, point32.z)
{
}

Vector3d::Vector3d(const geometry_msgs::Point &point)
    : Base(point.x, point.y, point.z)
{
}

Vector3d &Vector3d::operator=(const geometry_msgs::Vector3 &vector3)
{
    this->set_x(vector3.x);
    this->set_y(vector3.y);
    this->set_z(vector3.z);

    return *this;
}

Vector3d &Vector3d::operator=(const geometry_msgs::Point32 &point32)
{
    this->set_x(point32.x);
    this->set_y(point32.y);
    this->set_z(point32.z);

    return *this;
}

Vector3d &Vector3d::operator=(const geometry_msgs::Point &point)
{
    this->set_x(point.x);
    this->set_y(point.y);
    this->set_z(point.z);

    return *this;
}

geometry_msgs::Vector3 Vector3d::ToVector3() const
{
    geometry_msgs::Vector3 vector3;
    vector3.x = this->x();
    vector3.y = this->y();
    vector3.z = this->z();

    return vector3;
}

geometry_msgs::Point32 Vector3d::ToPoint32() const
{
    geometry_msgs::Point32 point32;
    point32.x = boost::numeric_cast<float>(this->x());
    point32.y = boost::numeric_cast<float>(this->y());
    point32.z = boost::numeric_cast<float>(this->z());

    return point32;
}

geometry_msgs::Point Vector3d::ToPoint() const
{
    geometry_msgs::Point point;
    point.x = this->x();
    point.y = this->y();
    point.z = this->z();

    return point;
}

template<typename OutputVectorType>
OutputVectorType Vector3d::ToGeometryMsgsVector() const
{
    OutputVectorType output;
    output.x = this->x();
    output.y = this->y();
    output.z = this->z();

    return output;
}

template geometry_msgs::Vector3 Vector3d::ToGeometryMsgsVector() const;
template geometry_msgs::Point Vector3d::ToGeometryMsgsVector() const;
template<>
geometry_msgs::Point32 Vector3d::ToGeometryMsgsVector() const
{
    return this->ToPoint32();
}

Vector2d Vector3d::ToVectorXy() const
{
    return Vector2d(this->x(), this->y());
}

// protected func.

// private func.

template<typename OutputVectorType>
void ToGeometryMsgsArray(
    const std::vector<Vector3d> &input,
    std::vector<OutputVectorType> &output)
{
    output.resize(input.size());
    std::transform(
        input.cbegin(),
        input.cend(),
        output.begin(),
        [](const Vector3d &vector3d)
        {return vector3d.ToGeometryMsgsVector<OutputVectorType>();});
}

template void ToGeometryMsgsArray(const std::vector<Vector3d> &, std::vector<geometry_msgs::Vector3> &);
template void ToGeometryMsgsArray(const std::vector<Vector3d> &, std::vector<geometry_msgs::Point32> &);
template void ToGeometryMsgsArray(const std::vector<Vector3d> &, std::vector<geometry_msgs::Point> &);

} // namespace geometry {
