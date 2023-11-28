import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var Messages: [Message] = []
    
    var messageTextField : UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Write Messages"
        return tf
    }()
    
    var messageView: UIView!
    
    var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()
    
    var tableView : UITableView = {
        let tableview = UITableView()
        tableview.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.separatorStyle = .none
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewSetUp()
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        // Do any additional setup after loading the view.
        loadMessage()
    }
    
    func loadMessage() {
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapShot, error) in
                self.Messages = []
                if let e = error {
                    print("There was issue retrieving data from Firetore. \(e)")
                }else {
                    if let snapShotDocument = querySnapShot?.documents {
                        for doc in snapShotDocument {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messsageBody = data["body"] as? String {
                                let newMessage = Message(sender: messageSender, body: messsageBody)
                                self.Messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let index = IndexPath(row: self.Messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: index, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    @objc func logOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signoutError as NSError {
            print("Error singing out %@", signoutError)
        }
    }
    
    @objc func sendPressed (_ sender: UIButton) {
        if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: ["sender" : sender, "body": messageBody, "date" : Date().timeIntervalSince1970]){
                (error) in
                if let e = error {
                    print("There was issue saving data due to firestore.\(e)")
                }else {
                    print("Successfully save data.")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    
    private func TableViewSetUp() {
        self.view.backgroundColor = .cyan
        
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        view.addSubview(tableView)
        
        messageView = UIView()
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.backgroundColor = .cyan
        view.addSubview(messageView)
        
        messageView.addSubview(messageTextField)
        
        messageView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            messageView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            messageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            messageTextField.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 8),
            messageTextField.widthAnchor.constraint(equalTo: messageView.widthAnchor,multiplier: 0.8, constant: -5),
            messageTextField.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 10),
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor),
            sendButton.widthAnchor.constraint(equalTo: messageView.widthAnchor, multiplier: 0.2, constant: -10),
            sendButton.topAnchor.constraint(equalTo: messageView.topAnchor,constant: 10),
            sendButton.heightAnchor.constraint(equalTo: messageTextField.heightAnchor)
            
        ])
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = Messages[indexPath.row]
        
        guard let senderCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else{
            fatalError("Table view could not dequeue in ChatViewController")
        }
        senderCell.messageBody.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            senderCell.SenderImageView.isHidden = true
            senderCell.SelfImageView.isHidden = false
        }
        //This is message form another user
        else {
            senderCell.SenderImageView.isHidden = false
            senderCell.SelfImageView.isHidden = true
        }
        
        return senderCell
        
    }
    
    
}

