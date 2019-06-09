//
//  ContentView.swift
//  SwiftUITest2
//
//  Created by Costantino Pistagna on 06/06/2019.
//  Copyright © 2019 sofapps.it All rights reserved.
//

import SwiftUI

struct DogsListView : View {
	@EnvironmentObject var dataSource: DogList
//	@ObjectBinding var dataSource = DogList()

	var body: some View {
		NavigationView {
			List {
				if dataSource.favorites.isEmpty == false {
					Section(header: Text("My favorite ones:")) {
						ForEach(dataSource.favorites) { row in
							DogCard(dataSource: row)
						}
					}
				}
				Section(header: Text("Available dogs:")) {
					ForEach(dataSource.items) { row in
						DogCard(dataSource: row)
					}
					.onDelete { indices in
						for i in indices.reversed() {
							self.dataSource.items.remove(at: i)
						}
					}
				}
			}
			.listStyle(.grouped)
			.navigationBarTitle(Text("My dogs"))
			.navigationBarItems(trailing: Button(action: {
				withAnimation { self.addDog() }
			}, label: {
				Image(systemName: "plus.circle")
				.imageScale(Image.Scale.large)
			}))
		}
	}
	
	private func addDog() {
		dataSource.items.append(Dog(name: "Another Dog", location: "Somewhere", description: "with some specific features"))
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		DogsListView()
	}
}
#endif
