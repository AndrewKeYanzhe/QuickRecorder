import SwiftUI
import AppKit

// MARK: - View Model
// An observable object to hold the state for the panel's content.
class PanelViewModel: ObservableObject {
    @Published var nitsValue: Float = 100.0
}

// MARK: - Floating Panel Controller
// This class manages the creation and behavior of the always-on-top NSPanel.
class FloatingPanelController {
    
    private var panel: NSPanel!
    // Create and own the view model that holds the dynamic data.
    private var viewModel = PanelViewModel()
    
    // You can create a single instance of this controller in your AppDelegate
    // or wherever you manage your app's lifecycle.
    // e.g., let floatingPanel = FloatingPanelController()
    
    init() {
        // 1. Create the SwiftUI view, now passing the view model to it.
        let swiftUIView = FloatingPanelView(viewModel: viewModel) { [weak self] in
            self?.close()
        }
        
        // 2. Create the NSPanel.
        panel = NSPanel(
            contentRect: .zero,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false)
        
        // 3. Configure the panel's behavior.
        panel.isReleasedWhenClosed = false
        panel.isMovableByWindowBackground = true
        panel.backgroundColor = .clear // Make the panel itself transparent
        
        // 4. This is the key line to make the window float above all other apps.
        panel.level = .floating
        
        // THIS IS THE NEW LINE: It ensures the panel is visible on all desktops (Spaces).
        panel.collectionBehavior = .canJoinAllSpaces
        
        // 5. Set the panel's content to our SwiftUI view.
        panel.contentView = NSHostingView(rootView: swiftUIView)
    }
    
    /// Shows the floating panel.
    func show() {
        // Position the panel in the top-right corner with a small gap from the edges.
        if let screen = NSScreen.main?.visibleFrame, let panelContent = panel.contentView {
            // Use the SwiftUI content's fitting size to get accurate dimensions.
            let panelSize = panelContent.fittingSize
            let gap: CGFloat = 20.0
            
            // Calculate the origin for the top-right position.
            let newOrigin = NSPoint(
                x: screen.origin.x + screen.size.width - panelSize.width - gap,
                y: screen.origin.y + screen.size.height - panelSize.height - gap
            )
            
            // Set both the origin and size of the panel's frame before showing.
            panel.setFrame(NSRect(origin: newOrigin, size: panelSize), display: false)
        }
        panel.orderFront(nil)
    }
    
    /// Closes the floating panel.
    func close() {
        panel.orderOut(nil)
    }
    
    /// Public method to update the value from another file.
    public func updateNitsValue(_ newValue: Float) {
        // **DEBUGGING STEP**: Print to the console to confirm this function is being called.
        print("FloatingPanelController: Attempting to update nits value to \(newValue)")
        
        // Update the value on the main thread to ensure UI updates are safe.
        DispatchQueue.main.async {
            self.viewModel.nitsValue = newValue
        }
    }
}


// MARK: - SwiftUI View for the Panel's Content
// This is the actual UI that will be displayed in the panel.
struct FloatingPanelView: View {
    
    // The view now observes the view model for changes.
    @ObservedObject var viewModel: PanelViewModel
    var closeAction: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            // The text content is now bound to the view model's property,
            // formatted to one decimal place.
            Text(String(format: "%.1f nits", viewModel.nitsValue))
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)

            // The close button
            Button(action: {
                closeAction()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(.secondary.opacity(0.7))
                    .onHover { hovering in
                        // Optional: slightly change appearance on hover
                        if hovering {
                            NSCursor.pointingHand.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
            }
            .buttonStyle(.plain)
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .frame(minWidth: 150)
    }
}

