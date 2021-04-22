//
//  ItemListView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)

            ForEach(items) { item in
                NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Image(systemName: "hexagon")
                            .font(.largeTitle)
                            .accentColor(Color(item.project?.projectColor ?? "Light Blue"))

                        VStack(alignment: .leading) {
                            Text(item.itemTitle)
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if item.itemDetail.isEmpty == false {
                                Text(item.itemDetail)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.secondarySystemGroupedBackground)
                    .cornerRadius(10)
                    .shadow( color: Color.black.opacity(0.2), radius: 5)
                }
            }
        }
    }
}
