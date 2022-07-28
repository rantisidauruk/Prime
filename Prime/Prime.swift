//
//  Prime.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//

import SwiftUI

@main
struct Prime: App {
		let persistenceController = PersistenceController.shared

		var body: some Scene {
				WindowGroup {
						ContentView()
								.environment(\.managedObjectContext, persistenceController.container.viewContext)
				}
		}
}
