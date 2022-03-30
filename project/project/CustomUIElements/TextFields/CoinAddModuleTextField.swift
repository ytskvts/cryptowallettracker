//
//  TypeOfSortTextField.swift
//  project
//
//  Created by Dzmitry on 11.02.22.
//
import UIKit

class CoinAddModuleTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10
    )
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupStyle()
    }
    
    func setupStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        //self.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 3
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) ||
            action == #selector(cut(_:)) ||
            action == #selector(copy(_:)) ||
            action == #selector(select(_:)) ||
            action == #selector(selectAll(_:)) ||
            action == #selector(delete(_:)) ||
            action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
            action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
            action == #selector(toggleBoldface(_:)) ||
            action == #selector(toggleItalics(_:)) ||
            action == #selector(toggleUnderline(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
