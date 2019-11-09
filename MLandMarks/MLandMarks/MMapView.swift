//
//  MMapView.swift
//  MLandMarks
//
//  Created by mal on 2019/11/6.
//  Copyright © 2019 mal. All rights reserved.
//

import SwiftUI
import MapKit

struct MMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 39.3, longitude: 116.0)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

