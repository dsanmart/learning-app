//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                Spacer()
                // Text
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .bold()
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)

                // Icons
                    HStack {
                        
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(.caption)
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(.caption)
                        
                    }
                    
                    
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
        }

        
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "description", count: "20 lessons", time: "2 hours")
    }
}
