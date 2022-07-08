//
//  Library.swift
//  iMusic
//
//  Created by admin on 08.07.2022.
//

import SwiftUI
import URLImage

struct Library: View {
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                GeometryReader { geometry in
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width * 0.48, height: 50)
                                .tint(.red).background(.bar)
                                .cornerRadius(10)
                        }
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: geometry.size.width * 0.48, height: 50)
                                .tint(.red).background(.bar)
                                .cornerRadius(10)
                        }
                        
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                //Spacer()
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture().onEnded({ _ in
                            print("Press")
                            self.track = track
                            showingAlert = true
                        }).simultaneously(with: TapGesture().onEnded({ _ in
                            
                            let keyWindow = UIApplication.shared.connectedScenes
                            .filter({$0.activationState == .foregroundActive})
                            .map({$0 as? UIWindowScene})
                            .compactMap({$0})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                            
                            let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                            tabBarVC?.trackDetailView.delegate = self
                            
                            self.track = track
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        })))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"), buttons: [.destructive(Text("Delete"), action: {
                    print("Deleting: \(self.track.trackName)")
                    self.delete(track: self.track)
                }), .cancel()
                ])
            })
         
                .navigationTitle("Library")
        }
    }
    func delete(at offset: IndexSet) {
        tracks.remove(atOffsets: offset)
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    var cell: SearchViewModel.Cell
    var body: some View {
        HStack {
            let url = URL(string: cell.iconUrlString ?? "")
            URLImage(url!) { image in
                image.resizable().frame(width: 60, height: 60).cornerRadius(5)
            }
            VStack(alignment: .leading) {
                Text(cell.trackName)
                Text(cell.artistName)
            }
        }
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
