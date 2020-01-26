//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Joshua Lee on 1/25/20.
//  Copyright © 2020 Joshua Lee. All rights reserved.
//

import UIKit

//@IBDesignable tells the Interface Builder to draw the contents of the stackview to the canvas
@IBDesignable class RatingControl: UIStackView
{
    //Array of buttons
    private var ratingButtons = [UIButton]()
    var rating = 0
    
    //@IBInspectable puts these properties in the Attributes Inspector of the storyboard
    //CGSize defines size of the buttons
    //didSet is a property observer. When adjusting properties in the Attributes Inspector, this property observer will change the width and height and number of stars. The purpose is to see the changes at design time.
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    {
        didSet
        {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5
    {
        didSet
        {
            setupButtons()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        setupButtons()
    }
    
    //@objc is needed because #selector is Objective C code 
    @objc func ratingButtonTapped(button: UIButton)
    {
        //if let is needed to unwrap the optional Int returned by ratingButtons.firstIndex
        //firstIndex finds the index of the selected button in the array but theres a
        //possibility that it doesn't exist so it returns optional Int
        //If the optional Int is nil it wont do anything
        if let index = ratingButtons.firstIndex(of: button)
        {
            // Calculate the rating of the selected button
            let selectedRating = index + 1
            
            if selectedRating == rating
            {
                // If the selected star represents the current rating, reset the rating to 0.
                rating = 0
            }
            else
            {
                // Otherwise set the rating to the selected star
                rating = selectedRating
            }
        }
    }

    private func setupButtons()
    {
        //Load images from assets catalog. The catalog is in the app's main bundle
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // clear any existing buttons for when you change the properties in the Attributes Inspector. When app is running, this wont affect it. Its only for designing.
        for button in ratingButtons
        {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount
        {
            //Creates a button
            let button = UIButton()
            //Button have states. Each state is defined with a corresponding image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // When instantiating a view(button), translatesAutoresizingMaskIntoConstraints defaults to true meaning the layout engine auto creates constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //Anchors are used to create constraints. In this case, constraints for the button's height and width
            //isActive tells the system to activate the constraints
            //As a result, a fixed size button 44 point by 44 point is created
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Instead of setting up a target-action pattern to link elements from storyboard to code with the IBAction attribute, this does the same thing
            //self refers to an instance of RatingControl
            //action: tells system to call ratingButtonTapped when button is tapped
            //touchUpInside is a touch event like in Android
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack view, RatingControl. As a result, RatingControl creates constraints for the button position
            addArrangedSubview(button)
            //Add button to list
            ratingButtons.append(button)
        }
    }
}
