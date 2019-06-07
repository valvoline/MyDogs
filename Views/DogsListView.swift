//
//  ContentView.swift
//  SwiftUITest2
//
//  Created by Costantino Pistagna on 06/06/2019.
//  Copyright © 2019 sofapps.it All rights reserved.
//

import SwiftUI

struct DogsListView : View {
	@State private var dataSource:[Dog] = [] //should the dataSource move to a complete different Struct? is fine to Bind it to the DogsListView itself?
	
	var body: some View {
		NavigationView {
			List {
				ForEach(dataSource) { row in
					DogCard(dataSource: row)
				}
				.onDelete { indices in
					for i in indices.reversed() {
						self.dataSource.remove(at: i)
					}
				}
			}
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
		dataSource.append(Dog(name: "Another Dog", location: "Somewhere", description: "with some specific features"))
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		DogsListView()
	}
}
#endif
