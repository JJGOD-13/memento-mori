//
//  MementoWidgetBundle.swift
//  MementoWidget
//
//  Created by Jayant Godse on 27/1/2025.
//

import WidgetKit
import SwiftUI

@main
struct MementoWidgetBundle: WidgetBundle {
    var body: some Widget {
        MementoWidget()
        MementoWidgetControl()
        MementoWidgetLiveActivity()
    }
}
