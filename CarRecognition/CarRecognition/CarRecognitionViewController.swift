import VisionLab

final class CarRecognitionViewController: ImageClassificationController<ClassificationService> {
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.button.setTitle("Choose an image of a car", for: .normal)
        classificationService.delegate = self
    }
}

// MARK: - ClassificationServiceDelegate

extension CarRecognitionViewController: ClassificationServiceDelegate {
    func classificationService(_ service: ClassificationService, didDetectCar car: String) {
        DispatchQueue.main.async { [weak mainView] in
            mainView?.label.text = car.capitalized
        }
    }
}
