//
//  BookingView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/05/2025.
//

import SwiftUI

struct BookingView: View {
    @StateObject private var vm = FormViewModel()
    @State private var presentSelectionSheet = false
    @State private var selectedDate = Date()
    @State private var isBooked = false
    
    var body: some View {
        Form {
            InputView(text: $vm.name, title: "Name", placeholder: "Name")
                .overlay(alignment: .bottomTrailing) { ResetButtonView().environmentObject(vm) }
            
            selectServiceSection
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .onChange(of: selectedDate) { _, _ in
                    Task { await vm.loadAvailableTimes(selectedDate) }
                }
                .padding(.vertical, 3)
            
            TimePickerView()
                .environmentObject(vm)
            
            if vm.selectedTime != nil {
                
                Text(vm.selectedTime?.dayViewDateFormat() ?? "")
                    .foregroundStyle(Color(.darkGray))
                    .padding(.vertical, 3)
            }
        }
        .navigationTitle("Book Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task { await vm.loadAvailableTimes(selectedDate) }
            Task { try await vm.fetchServices() }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .headline, fontColor: Color(.darkGray))
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Book") {
                    vm.showConfirmationAlert.toggle()
                }
                .font(.headline)
                .disabled(!vm.formValidation)
            }
        }
        .fullScreenCover(isPresented: $isBooked) {
            NavigationStack {
                // present confirmation sheet
                BookedView(date: selectedDate)
                    .environmentObject(vm)
            }
        }
        .confirmationDialog("Appointment", isPresented: $vm.showConfirmationAlert, titleVisibility: .visible) {
            Button("Yes") {
                Task { try await vm.bookAppointments(for: selectedDate) }
                isBooked.toggle()
            }
        } message: {
            Text("Do you want to book appointment for this date?")
        }
    }
}

#Preview {
    NavigationStack {
        BookingView()
            .environmentObject(FormViewModel())
    }
}

extension BookingView {
    private var selectServiceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Serivce")
                .font(.callout).bold()
                .foregroundStyle(Color(.label))
            
            Button {
                withAnimation(.easeInOut) {
                    presentSelectionSheet.toggle()
                }
            } label: {
                HStack {
                    Text((vm.selectedSerivce == nil ? "none" : vm.selectedSerivce?.title) ?? "")
                        .foregroundStyle(Color(.darkGray))
                        .autocapitalization(.none)
                    Spacer()
                    Image(systemName: presentSelectionSheet ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color(.darkGray))
                }
            }
        }
        .padding(.vertical, 3)
        .sheet(isPresented: $presentSelectionSheet) {
            NavigationStack {
                // present service selection sheet
                SelectionSheet(selection: $vm.selectedSerivce, items: vm.services)
            }
        }
    }
}
