//
//  Waypoint.h
//  SingleViewWaypoints
//
//  Created by Deepa  Katoch on 3/19/15.
//  Copyright (c) 2015 Deepa  Katoch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    Statute,
    Nautical,
    Kmeter
} Units;

#define radiusE 6371



@interface Waypoint : NSObject

//public properties of the waypoint include lat, lon, and name
@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (strong, nonatomic) NSString * name;

// initialize a waypont object with values
- (id) initWithLat: (double) lat
               lon: (double) lon
              name: (NSString *) name;

// a string representation of the waypoint
- (NSString*) toString;

// great circle (an arc not a straight line) distance from this waypoint to lat, lon
- (double) distanceGCTo: (double) lat lon: (double) lon scale: (Units) scale;

// initial true heading for the great circle route. heading changes continuously.
- (double) bearingGCInitTo: (double) lat lon: (double) lon;


@end
