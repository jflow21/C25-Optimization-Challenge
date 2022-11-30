"""
    speed(street)

Returns the speed of a street.
"""
function speed(street::Street)
    return street.distance / street.duration
end
