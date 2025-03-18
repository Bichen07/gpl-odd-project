"""
This script provides coordinate transformations from Geodetic -> ECEF, ECEF -> ENU
and Geodetic -> ENU (the composition of the two previous functions). Running the script
by itself runs tests.
based on https://gist.github.com/govert/1b373696c9a27ff4c72a.
"""
import math

a = 6378137
b = 6356752.3142
f = (a - b) / a
e_sq = f * (2-f)

def geodetic_to_ecef(lat, lon, h):
    # (lat, lon) in WSG-84 degrees
    # h in meters
    lamb = math.radians(lat)
    phi = math.radians(lon)
    s = math.sin(lamb)
    N = a / math.sqrt(1 - e_sq * s * s)

    sin_lambda = math.sin(lamb)
    cos_lambda = math.cos(lamb)
    sin_phi = math.sin(phi)
    cos_phi = math.cos(phi)

    x = (h + N) * cos_lambda * cos_phi
    y = (h + N) * cos_lambda * sin_phi
    z = (h + (1 - e_sq) * N) * sin_lambda

    return x, y, z

def ecef_to_geodetic(x, y, z):
    eps = e_sq / (1.0 - e_sq);
    p = math.sqrt(x * x + y * y);
    q = math.atan2((z * a), (p * b));
    sin_q = math.sin(q);
    cos_q = math.cos(q);
    sin_q_3 = sin_q * sin_q * sin_q;
    cos_q_3 = cos_q * cos_q * cos_q;
    phi = math.atan2((z + eps * b * sin_q_3), (p - e_sq * a * cos_q_3));
    lambda_ = math.atan2(y, x);
    v = a / math.sqrt(1.0 - e_sq * math.sin(phi) * math.sin(phi));
    h = (p / math.cos(phi)) - v;

    lat = math.degrees(phi);
    lon = math.degrees(lambda_);

    return lat, lon, h

def ecef_to_enu(x, y, z, lat0, lon0, h0):
    lamb = math.radians(lat0)
    phi = math.radians(lon0)
    s = math.sin(lamb)
    N = a / math.sqrt(1 - e_sq * s * s)

    sin_lambda = math.sin(lamb)
    cos_lambda = math.cos(lamb)
    sin_phi = math.sin(phi)
    cos_phi = math.cos(phi)

    x0 = (h0 + N) * cos_lambda * cos_phi
    y0 = (h0 + N) * cos_lambda * sin_phi
    z0 = (h0 + (1 - e_sq) * N) * sin_lambda

    xd = x - x0
    yd = y - y0
    zd = z - z0

    xEast = -sin_phi * xd + cos_phi * yd
    yNorth = -cos_phi * sin_lambda * xd - sin_lambda * sin_phi * yd + cos_lambda * zd
    zUp = cos_lambda * cos_phi * xd + cos_lambda * sin_phi * yd + sin_lambda * zd

    return xEast, yNorth, zUp

def enu_to_ecef(xEast, yNorth, zUp, lat0, lon0, h0):
    lamb = math.radians(lat0)
    phi = math.radians(lon0)
    s = math.sin(lamb)
    N = a / math.sqrt(1 - e_sq * s * s)

    sin_lambda = math.sin(lamb)
    cos_lambda = math.cos(lamb)
    sin_phi = math.sin(phi)
    cos_phi = math.cos(phi)

    x0 = (h0 + N) * cos_lambda * cos_phi
    y0 = (h0 + N) * cos_lambda * sin_phi
    z0 = (h0 + (1 - e_sq) * N) * sin_lambda

    xd = -sin_phi * xEast - cos_phi * sin_lambda * yNorth + cos_lambda * cos_phi * zUp;
    yd = cos_phi * xEast - sin_lambda * sin_phi * yNorth + cos_lambda * sin_phi * zUp;
    zd = cos_lambda * yNorth + sin_lambda * zUp;

    x = xd + x0
    y = yd + y0
    z = zd + z0

    return x, y, z

def geodetic_to_enu(lat, lon, h, lat_ref, lon_ref, h_ref):
    x, y, z = geodetic_to_ecef(lat, lon, h)

    return ecef_to_enu(x, y, z, lat_ref, lon_ref, h_ref)

def enu_to_geodetic(xEast, yNorth, zUp, lat_ref, lon_ref, h_ref):
    x, y, z = enu_to_ecef(xEast, yNorth, zUp, lat_ref, lon_ref, h_ref)

    return ecef_to_geodetic(x, y, z)

if __name__ == '__main__':
    def are_close(a, b):
        return abs(a-b) < 1e-4

    latLA = 34.00000048
    lonLA = -117.3335693
    hLA = 251.702

    x0, y0, z0 = geodetic_to_ecef(latLA, lonLA, hLA)
    x = x0 + 1
    y = y0
    z = z0
    xEast, yNorth, zUp = ecef_to_enu(x, y, z, latLA, lonLA, hLA)
    assert are_close(0.88834836, xEast)
    assert are_close(0.25676467, yNorth)
    assert are_close(-0.38066927, zUp)

    x = x0
    y = y0 + 1
    z = z0
    xEast, yNorth, zUp = ecef_to_enu(x, y, z, latLA, lonLA, hLA)
    assert are_close(-0.45917011, xEast)
    assert are_close(0.49675810, yNorth)
    assert are_close(-0.73647416, zUp)

    x = x0
    y = y0
    z = z0 + 1
    xEast, yNorth, zUp = ecef_to_enu(x, y, z, latLA, lonLA, hLA)
    assert are_close(0.00000000, xEast)
    assert are_close(0.82903757, yNorth)
    assert are_close(0.55919291, zUp)
