//
//  AttachmentViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 13.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import MessageUI

class AttachmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum MIMEType: String {
        case jpg = "image/jpg"
        case png = "image/png"
        case doc = "application/msword"
        case ppt = "application/vnd.ms-powerpoint"
        case html = "text/html"
        case pdf = "application/pdf"
        
        init?(type: String){
            switch type.lowercased(){
            case "jpg": self = .jpg
            case "png": self = .png
            case "doc": self = .doc
            case "ppt": self = .ppt
            case "html": self = .html
            case "pdf": self = .pdf
            default: return nil
            }
            
        }
    }
    
    
    
    @IBOutlet var tableView: UITableView!
    
    let filenames = ["photo1.jpg", "photo2.jpg", "photo3.jpg", "photo4.jpg"]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return filenames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row)");
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = filenames[indexPath.row]
        showEmail(attachment: selectedFile)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showEmail(attachment: String){
        
        guard MFMailComposeViewController.canSendMail() else{
            print ("This device doesn't allow you to send mail")
            return
        }
        
        let emailTitle = "Test Title"
        let messageBody = "Hey, this is first test"
        let toRecipients = ["martusia.piatek@gmail.com"]
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        let fileparts = attachment.components(separatedBy: ".")
        let filename = fileparts[0]
        let fileExtension = fileparts[1]
        
        guard let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension) else{
            return
        }
        
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let mimeType = MIMEType(type: fileExtension) {
            
            mailComposer.addAttachmentData(fileData, mimeType: mimeType.rawValue, fileName: filename)
            
            present(mailComposer, animated: true, completion: nil)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AttachmentViewController: MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Failed to send \(error?.localizedDescription ?? "")")
        }
        dismiss(animated: true, completion: nil)
    }
}
