//
//  Waypoint.m
//  SingleViewWaypoints
//
//  Created by Deepa  Katoch on 3/19/15.
//  Copyright (c) 2015 Deepa  Katoch. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint
- initWithLat: (double) lat lon: (double) lon name: (NSString*) name {
    if ( (self = [super init]) ) {
        self.lat = lat;
        self.lon = lon;
        self.name = name;
    }
    return self;
}

- (NSString*) toString {
    return [NSString stringWithFormat:@"Waypoint name: %s, lat: %6.4f, lon: %6.4f",
            [self.name UTF8String], self.lat, self.lon];
}

- (double) distanceGCTo: (double) lat lon: (double) lon scale: (Units) scale{
    double ret = 0.0;
    double dlatRad = [self toRadians: (lat - self.lat)];
    double dlonRad = [self toRadians: (lon - self.lon)];
    double latOrgRad = [self toRadians: (self.lat)];
    double a = sin(dlatRad/2) * sin(dlatRad/2) +
    sin(dlonRad/2) * sin(dlonRad/2) * cos(latOrgRad) *
    cos([self toRadians: lat]);
    ret = radiusE * (2 * atan2(sqrt(a), sqrt(1 - a)));
    // ret is already in kilometers. switch to either Statute or Nautical?
    switch(scale) {
        case Statute:
            ret = ret * 0.62137119;
            break;
        case Nautical:
            ret = ret * 0.5399568;
            break;
    }
    return ret;
}

- (double) bearingGCInitTo: (double) lat lon: (double) lon {
    double ret = 0.0;
    double dlonRad = [self toRadians: (lon - self.lon)];
    double latOrgRad = [self toRadians: (self.lat)];
    double y = sin(dlonRad) * cos([self toRadians: lat]);
    double x = cos(latOrgRad)*sin([self toRadians:lat]) -
    sin(latOrgRad)*cos([self toRadians: lat])*
    cos(dlonRad);
    ret = [self toDegrees: atan2(y,x)];
    ret = fmod((ret+360.0),360.0);
    return ret;
}

- (double) toRadians: (double) angle {
    return angle * M_PI / 180.0;
}

- (double) toDegrees: (double) radians {
    return radians * (180.0 / M_PI);
}


@end
