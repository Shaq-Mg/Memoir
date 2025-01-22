//
//  Day.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

struct Day: Identifiable, Hashable {
    @DocumentID var id: String?
    let booking: Int
    let date: Date

}
