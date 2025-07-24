# Distributed Systems Technical Glossary
*Organized by Theme with Alphabetical Ordering*

## 1. Architecture and Design Patterns

### Core System Types
**Cluster Computing**: Collection of similar compute nodes interconnected by high-speed network, running the same operating system.

**Component**: A modular unit with well-defined required and provided interfaces that is replaceable within its environment.

**Connector**: A mechanism that mediates communication, coordination, or cooperation among components (e.g., facilities for remote procedure calls, message passing, or streaming data).

**Decentralized System**: A networked computer system in which processes and resources are necessarily spread across multiple computers.

**Distributed System**: A networked computer system in which processes and resources are sufficiently spread across multiple computers.

**Networked Computer System**: A collection of computers connected in a network.

### Architectural Styles
**Architectural Style**: Formulated in terms of components, the way components are connected to each other, the data exchanged between components, and how these elements are jointly configured into a system.

**Event-based Coordination**: Referentially decoupled and temporally coupled systems where processes publish notifications and subscribe to specific events.

**Layered Architecture**: Components are organized in a layered fashion where a component at layer Lj can make a downcall to a component at a lower-level layer Li and generally expects a response.

**Microservices**: Services that run as separate network processes, representing independent, modular services where size and true separation matter.

**Object-based Architectural Style**: Each object corresponds to a component, connected through a procedure-call mechanism, where calls can take place over a network.

**Peer-to-Peer System**: Processes that are all equal, where functions are represented by every process and interaction is symmetric.

**Publish-Subscribe Architecture**: Architecture with strong separation between processing and coordination, where processes communicate by describing events they're interested in.

**RESTful Architectures**: Systems with four key characteristics: (1) resources identified through single naming scheme, (2) all services offer same interface with at most four operations, (3) messages are fully self-described, (4) stateless execution.

**Service-Oriented Architecture (SOA)**: An architectural style reflecting a loose organization into a collection of separate, independent entities where each entity encapsulates a service.

**Software Architecture**: The logical organization of a distributed system into software components that tells us how various software components are to be organized and how they should interact.

### Client-Server Models
**Client**: A process that requests a service from a server by sending a request and waiting for the server's reply.

**Fat Client**: Client machines that do substantial processing and have more functionality.

**Server**: A process implementing a specific service (e.g., file system service, database service).

**Thin Client**: Client machines that do minimal processing, with most functionality on the server side.

**Three-tiered Architecture**: Architecture where programs from the processing layer are executed by a separate server, potentially distributed across client and server machines.

**Two-tiered Architecture**: A physical distribution with only client machines and server machines.

## 2. Communication and Protocols

### Communication Fundamentals
**Asynchronous Communication**: A sender continues immediately after it has submitted its message for transmission.

**Communication Protocol**: Rules that govern the format, contents, and meaning of messages sent and received between communicating processes.

**Connection-oriented Service**: A communication service where sender and receiver first explicitly establish a connection and possibly negotiate specific protocol parameters before exchanging data.

**Connectionless Service**: A communication service where no setup in advance is needed; the sender just transmits the first message when ready.

**Persistent Communication**: A message submitted for transmission is stored by the communication middleware as long as it takes to deliver it to the receiver.

**Synchronous Communication**: The sender is blocked until its request is known to be accepted.

**Transient Communication**: A message is stored by the communication system only as long as the sending and receiving applications are executing.

### Network Protocols
**Advanced Message-Queuing Protocol (AMQP)**: A protocol specification for message-queuing systems to enable interoperability.

**HyperText Transfer Protocol (HTTP)**: The standardized communication protocol between browsers and web servers.

**IP (Internet Protocol)**: The Internet's connectionless network protocol.

**TCP (Transmission Control Protocol)**: The Internet's reliable, connection-oriented transport protocol.

**UDP (Universal Datagram Protocol)**: The Internet's connectionless transport protocol.

### Remote Procedure Calls
**Asynchronous RPC**: An RPC where the server immediately sends a reply back as acknowledgment, then processes the request locally.

**Callback**: A user-defined function invoked when a special event happens, such as an incoming message.

**Client Stub**: A piece of code that transforms local procedure calls into network messages and handles responses.

**Deferred Synchronous RPC**: An RPC scheme where the client waits for acceptance, continues execution, and receives results via callback later.

**Interface Definition Language (IDL)**: A language used to specify interfaces that can be compiled into client and server stubs.

**Multicast RPC**: Sending an RPC request to a group of servers simultaneously.

**One-way RPC**: An RPC where the client continues immediately after sending the request without waiting for acknowledgment.

**Parameter Marshaling**: The process of packing parameters into a message for network transmission.

**Remote Procedure Call (RPC)**: A method allowing programs to call procedures located on other machines, making remote service calls look like local procedure calls.

**Server Stub**: The server-side equivalent of a client stub that transforms network requests into local procedure calls.

**Unmarshaling**: The process of unpacking parameters from a network message.

### Message-Oriented Communication
**Message Broker**: Special nodes in a queuing network that act as application-level gateways to convert messages between different formats/protocols.

**Message-Oriented Middleware (MOM)**: Middleware systems that provide extensive support for persistent asynchronous communication.

**Message-Passing Interface (MPI)**: A standard for message passing designed for parallel applications and transient communication.

**Message-Queuing System**: Systems that offer intermediate-term storage capacity for messages without requiring sender or receiver to be active during transmission.

**Pipeline Pattern**: Communication pattern where processes push results to other processes that pull them in.

**Publish-Subscribe Pattern**: Communication pattern where clients subscribe to specific messages published by servers.

**Queue Manager**: A process that manages queues, either as a separate process or implemented through a library.

**Request-Reply Pattern**: Traditional client-server communication pattern used in ZeroMQ.

**Socket**: A communication endpoint to which an application can write data to be sent over the network and from which incoming data can be read.

## 3. Coordination and Synchronization

### Time and Clock Synchronization
**Accuracy (α)**: The maximum deviation from an external reference point like UTC: ∀t, ∀p : |Cₚ(t) − t| ≤ α

**Atomic Second**: The time it takes the cesium 133 atom to make exactly 9,192,631,770 transitions.

**Clock Drift**: Hardware clocks are subject to clock drift because their frequency is not perfect and affected by external sources such as temperature.

**Clock Drift Rate**: The difference per unit of time from a perfect reference clock. A typical quartz-based hardware clock has a clock drift rate of some 10⁻⁶ seconds per second.

**Clock Skew**: The difference in time values between different clocks when read out, caused by crystals running at slightly different rates.

**External Synchronization**: Keeping clocks accurate (within a specified bound to an external reference).

**Internal Synchronization**: Keeping clocks precise (within a specified bound between machines).

**Leap Seconds**: Corrections introduced by BIH when the discrepancy between TAI and solar time grows to 800 msec.

**Mean Solar Second**: 1/86400th of a mean solar day, computed by averaging a large number of days.

**Precision (π)**: The maximum deviation between the respective clocks of any two machines in a distributed system: ∀t, ∀p, q : |Cₚ(t) − Cᵨ(t)| ≤ π

**Solar Day**: The interval between two consecutive transits of the sun.

**TAI (International Atomic Time)**: The mean number of ticks of cesium 133 clocks since midnight on Jan. 1, 1958, divided by 9,192,631,770.

**UTC (Coordinated Universal Time)**: The basis of all modern civil timekeeping and a worldwide standard.

### Logical Clocks and Ordering
**Causal History**: The set of all events that causally precede a given event.

**Concurrent Events**: Events x and y that happen in different processes that do not exchange messages, where neither x → y nor y → x is true.

**Happens-Before Relation (→)**: A relation where a → b means "event a happens before event b" and all processes agree on this ordering.

**Lamport's Logical Clocks**: Each process maintains a local counter that is incremented before executing events and adjusted when receiving messages to maintain the happens-before relationship.

**Logical Clock**: A way of measuring time such that for every event a, we can assign it a time value C(a) with the property that if a → b, then C(a) < C(b).

**State Machine Replication**: Keeping replicas consistent by letting them execute the same operations in the same order everywhere.

**Totally Ordered Multicast**: A multicast operation by which all messages are delivered in the same order to each receiver.

**Vector Clocks**: Clocks that capture causality by maintaining vectors where VCᵢ[i] is the number of events at process Pᵢ, and VCᵢ[j] = k means Pᵢ knows that k events have occurred at Pⱼ.

### Mutual Exclusion and Consensus
**Bully Algorithm**: An election algorithm where the process with the highest identifier wins and "bullies" lower-numbered processes.

**Candidate State**: In Raft, the state a server enters when it believes the leader has crashed and starts an election.

**Consensus**: Agreement among group members on which operation to perform, with requirements: Processes produce the same output value, Every output value must be valid, Every process must eventually provide output.

**Critical Region**: A section of code that can be executed by at most one process at a time.

**Deadlock**: A situation where several processes are indefinitely waiting for each other to proceed.

**Follower State**: In Raft, the initial state where servers wait for messages from a leader.

**Leader Election**: Algorithms for electing a coordinator when one process needs to act as coordinator, initiator, or perform some special role.

**Leader State**: In Raft, the state of the server that coordinates operations and sends heartbeats.

**Mutual Exclusion**: Ensuring that multiple processes do not simultaneously access a shared resource.

**Permission-Based Solutions**: A process wanting to access a resource requires permission from other processes.

**Proof of Stake**: A leader election method where the probability of being chosen as leader is proportional to the number of tokens owned.

**Proof of Work**: A computational race where candidates solve a computational puzzle to become leader.

**Raft**: Consensus protocol for crash-failure semantics with replicated servers maintaining operation logs.

**Ring Algorithm**: An election algorithm that uses a logical ring where election messages circulate around the ring.

**Starvation**: A situation where a process never gets a chance to access a shared resource.

**Term**: In Raft, a numbered period during which there is exactly one leader.

**Token-Based Solutions**: Mutual exclusion achieved by passing a special message (token) between processes; only the token holder can access the resource.

## 4. Consistency and Replication

### Consistency Models
**Causal Consistency**: A consistency model where writes that are potentially causally related must be seen by all processes in the same order. Concurrent writes may be seen in a different order on different machines.

**Consistency**: A property ensuring that when one copy of replicated data is updated, all other copies are updated as well so that replicas remain the same.

**Consistency Model (Data-centric)**: A contract between processes and the data store that specifies what processes can expect when reading and updating shared data, knowing that others are accessing that data as well.

**Continuous Consistency**: A consistency model that distinguishes three independent axes for defining inconsistencies: Numerical deviation, Staleness deviation, Ordering deviation.

**CRDT (Conflict-Free Replicated Data Type)**: A data type that can be replicated at many different sites and updated concurrently without further coordination.

**Entry Consistency**: A consistency model that uses synchronization variables (locks).

**Eventual Consistency**: A consistency model where if no updates take place for a long time, all replicas will gradually become consistent.

**Linearizability**: Each operation should appear to take effect instantaneously at some moment between its start and completion.

**Sequential Consistency**: A data store is sequentially consistent when the result of any execution is the same as if operations were executed in some sequential order.

**Strong Eventual Consistency**: Ensures that if there are conflicting updates, the replicas where those updates have taken place are in the same state.

### Client-Centric Consistency
**Client-Centric Consistency**: Consistency models that provide guarantees for a single client concerning the consistency of accesses to a data store by that client.

**Monotonic Reads**: If a process reads the value of a data item x, any successive read operation on x by that process will always return that same value or a more recent value.

**Monotonic Writes**: A write operation by a process on a data item x is completed before any successive write operation on x by the same process.

**Read-Your-Writes Consistency**: The effect of a write operation by a process on data item x will always be seen by a successive read operation on x by the same process.

**Writes-Follow-Reads Consistency**: A write operation by a process on a data item x following a previous read operation on x by the same process is guaranteed to take place on the same or a more recent value of x that was read.

### Replication Types and Protocols
**Active Replication**: A replication strategy where each replica has an associated process that carries out update operations, with operations forwarded to all replicas.

**Cache Hit**: When requested data can be fetched from the local cache.

**Client-Initiated Replicas (Client Caches)**: Local storage facilities used by clients to temporarily store copies of recently requested data, managed entirely by the client.

**Permanent Replicas**: The initial set of replicas that constitute a distributed data store.

**Primary-Backup Protocol**: A consistency protocol where all write operations are forwarded to a fixed single server (primary), which then updates backup servers.

**Primary-Based Protocols**: Protocols where each data item has an associated primary server responsible for coordinating write operations on that item.

**Pull-Based Protocols (Client-Based)**: A server or client requests another server to send any updates it has at that moment.

**Push-Based Protocols (Server-Based)**: Updates are propagated to other replicas without those replicas asking for updates.

**Quorum-Based Protocols**: Voting-based protocols requiring clients to request and acquire permission from multiple servers before reading or writing replicated data.

**Read Quorum (NR)**: An arbitrary collection of any NR servers required to read a file.

**Replication**: The process of maintaining multiple copies of data across different locations in a distributed system.

**Replicated-Write Protocols**: Protocols where write operations can be carried out at multiple replicas instead of only one.

**ROWA (Read-One, Write-All)**: A quorum-based protocol where NR = 1 but must write to all replicas.

**Server-Initiated Replicas**: Copies of a data store created at the initiative of the data store owner to enhance performance.

**Write Quorum (NW)**: At least NW servers required to modify a file, subject to constraints NR + NW > N and NW > N/2.

**Write-Back Cache**: A cache where propagation of updates is delayed, allowing multiple writes before informing servers.

**Write-Through Cache**: A cache where clients can directly modify cached data and forward updates to servers.

## 5. Fault Tolerance and Reliability

### Dependability Properties
**Availability**: The property that a system is ready to be used immediately. Refers to the probability that the system is operating correctly at any given moment.

**Dependability**: The degree that a computer system can be relied upon to operate as expected.

**Fault Tolerance**: A characteristic feature where a distributed system can automatically recover from partial failures without seriously affecting overall performance.

**Maintainability**: How easily a failed system can be repaired.

**Reliability**: The property that a system can run continuously without failure over a time interval.

**Safety**: When a system temporarily fails to operate correctly, no catastrophic event happens.

### Failure Models
**Arbitrary Failures (Byzantine Failures)**: The most serious type where servers may produce output they should never have produced, but which cannot be detected as being incorrect.

**Crash Failure**: When a server prematurely halts but was working correctly until it stopped.

**Error**: A part of a system's state that may lead to a failure.

**Fail-arbitrary Failures**: Process may fail in any possible way; failures may be unobservable and harmful.

**Fail-noisy Failures**: Like fail-stop failures, but detection process will only eventually come to correct conclusion.

**Fail-safe Failures**: Dealing with arbitrary failures that are benign and cannot do harm.

**Fail-silent Failures**: Communication links are nonfaulty, but process cannot distinguish crash failures from omission failures.

**Fail-stop Failures**: Crash failures that can be reliably detected.

**Failure**: When a system cannot meet its promises.

**Fault**: The cause of an error.

**Intermittent Faults**: Occur, then vanish of their own accord, then reappear.

**Omission Failure**: When a server fails to respond to a request.

**Partial Failure**: A distinguishing feature of distributed systems where part of the system is failing while the remaining part continues to operate.

**Permanent Faults**: Continue to exist until the faulty component is replaced.

**Performance Failure**: When a server responds too late.

**Response Failure**: When the server's response is incorrect.

**System Failure**: When a distributed system does not meet its promises or cannot provide one or more of its designed services completely.

**Timing Failure**: When the response lies outside a specified real-time interval.

**Transient Faults**: Occur once and then disappear.

### Recovery and Checkpointing
**Backward Recovery**: Bringing system from erroneous state back to previously correct state.

**Checkpoint**: Recording of system's state at a particular time.

**Coordinated Checkpointing**: All processes synchronize to jointly write state to local storage.

**Distributed Snapshot**: Consistent global state where if process recorded receipt of message, another process recorded sending it.

**Domino Effect**: Cascaded rollback that may lead to rolling back to initial system state.

**Forward Recovery**: Bringing system to correct new state from which it can continue executing.

**Independent Checkpointing**: Each process records local state in uncoordinated fashion.

**Message Logging**: Technique reducing checkpoint frequency while enabling recovery by replaying message transmissions.

**Optimistic Logging**: Handles orphan processes by rolling them back after crash occurs.

**Orphan Process**: Process that survives crash of another process but whose state is inconsistent with crashed process after recovery.

**Pessimistic Logging**: Ensures at most one process dependent on each nonstable message.

**Recovery Line**: Most recent consistent collection of checkpoints.

### Consensus and Agreement
**Byzantine Agreement Requirements**: BA1: Every nonfaulty backup process stores the same value. BA2: If the primary is nonfaulty, then every nonfaulty backup process stores exactly what the primary sent.

**CAP Theorem**: Any networked system providing shared data can provide only two of three properties: Consistency, Availability, Partition Tolerance.

**Flooding Consensus**: Algorithm operating in rounds where processes send lists of proposed commands to each other.

**Paxos**: Consensus algorithm operating under weak assumptions with proposers, acceptors, and learners.

**Three-phase Commit (3PC)**: Nonblocking commit protocol avoiding blocking in presence of fail-stop crashes.

**Two-phase Commit (2PC)**: Two-phase protocol with voting phase and decision phase.

## 6. Naming and Location

### Core Naming Concepts
**Access Point**: A special kind of entity that allows access to another entity. The name of an access point is called an address.

**Address**: The name of an access point of an entity; also simply called an address of that entity.

**Entity**: Practically anything in a distributed system that can be operated on.

**Human-Friendly Names**: Names tailored to be used by humans, generally represented as character strings.

**Identifier (True Identifier)**: A name that has three specific properties: refers to at most one entity, each entity is referred to by at most one identifier, always refers to the same entity.

**Location Independent Name**: A name for an entity that is independent of its addresses, making it easier and more flexible to use.

**Name**: A string of bits or characters that is used to refer to an entity in a distributed system.

### Naming Systems
**Attribute-Based Naming**: A naming approach where an entity is described through various characteristics using (attribute, value) pairs.

**Flat Naming Systems**: Systems where entities are referred to by an identifier that has no meaning and bears no structure.

**Structured Naming**: Names that are composed from simple, human-readable names, often organized hierarchically.

### Name Resolution
**Absolute Path Name**: A path name where the first node is the root of the naming graph.

**Alias**: Another name for the same entity.

**Closure Mechanism**: The mechanism that deals with selecting the initial node in a name space from which name resolution is to start.

**Directory Node**: A node with outgoing edges, each labeled with a name, storing a directory table.

**Global Name**: A name that denotes the same entity regardless of where it is used in a system.

**Hard Link**: Multiple absolute path names that refer to the same node in a naming graph.

**Iterative Name Resolution**: A method where a name resolver hands over the complete name to a server.

**Leaf Node**: A node that represents a named entity and has no outgoing edges.

**Local Name**: A name whose interpretation depends on where it is being used.

**Name Resolution**: The process of looking up information stored in a node referred to by a name.

**Name Space**: An organization of names, represented as a labeled, directed graph with leaf nodes and directory nodes.

**Path Name**: A sequence of labels corresponding to edges in a path through a naming graph.

**Recursive Name Resolution**: A method where a name server passes intermediate results to the next name server it finds.

**Relative Path Name**: A path name where the first node is not the root of the naming graph.

**Symbolic Link**: A leaf node that stores an absolute path name instead of the address or state of an entity.

### Distributed Hash Tables
**Distributed Hash Table (DHT)**: A system that uses an m-bit identifier space to assign randomly chosen identifiers to nodes as well as keys to specific entities.

**Finger Table**: In Chord, a table containing s ≤ m entries where the ith entry points to the first node succeeding p by at least 2^(i-1) units.

**Semantic-free Index**: Each data item is uniquely associated with a key using a hash function.

**Successor**: In Chord, the node with the smallest identifier id ≥ k for a given key k, denoted as succ(k).

### DNS and Directory Services
**Directory Information Base (DIB)**: The collection of all directory entries in an LDAP directory service.

**Directory Service**: An attribute-based naming system where entities have associated attributes that can be used for searching.

**DNSSEC**: DNS Security extensions that provide validation of DNS responses through digital signatures.

**Domain**: In DNS, a subtree of the name space; the path name to its root node is called a domain name.

**Domain Name System (DNS)**: Hierarchically organized tree of domains divided into zones, each handled by a name server.

**Resource Record**: The contents of a node in DNS, with different types (SOA, A, MX, SRV, NS, CNAME, PTR, HINFO, TXT).

**Zone**: In DNS, a part of the name space that is implemented by a separate name server.

**Zone Transfer**: In DNS, the process by which secondary name servers request the primary server to transfer its content.

## 7. Security

### Core Security Concepts
**Authentication**: Used to verify the claimed identity of a user, client, server, host, device, and so on.

**Authorization**: Checking whether an authenticated client is authorized to perform the requested action.

**Confidentiality**: The property that information is disclosed only to authorized parties.

**Integrity**: The characteristic that alterations to a system's assets can be made only in an authorized way.

**Security Mechanisms**: The means by which a security policy can be enforced: Encryption, Authentication, Authorization, Monitoring and auditing.

**Security Policy**: A description of security requirements that specifies precisely which actions the entities in a system are allowed to take and which ones are prohibited.

### Cryptography
**Asymmetric Cryptosystem**: A cryptographic system where the keys for encryption and decryption are different but form a unique pair (also called public-key systems).

**Ciphertext**: The encrypted form of a message.

**Digital Signature**: A way to uniquely associate a signature with a specific message to prevent modifications and repudiation.

**Hash Function**: Takes a message of arbitrary length as input and produces a bit string of fixed length as output.

**Homomorphic Encryption**: Encryption where mathematical operations on plaintext can also be performed on the corresponding ciphertext.

**Message Digest**: A fixed-length bit string computed from an arbitrary-length message through a cryptographic hash function.

**Nonce**: A random number that is used only once, chosen from a very large set to uniquely relate two messages.

**One-way Function**: Computationally infeasible to find the input that corresponds to a known output.

**Plaintext**: The original form of the message that is sent.

**Strong Collision Resistance**: Computationally infeasible to find any two different input values that produce the same hash output.

**Symmetric Cryptosystem**: A cryptographic system where the same key is used to encrypt and decrypt a message.

**Weak Collision Resistance**: Given an input and its hash output, it is computationally infeasible to find another different input that produces the same hash.

### Authentication and Key Management
**Certificate Revocation List (CRL)**: A list published regularly by a certification authority of certificates that have been revoked.

**Challenge-response Protocol**: One party challenges the other to a response that can be correct only if the other knows a shared secret.

**Cipher Suite**: The collection of cryptographic algorithms used in a TLS connection.

**Diffie-Hellman Key Exchange**: A protocol for establishing a shared secret key across an insecure channel without prior key exchange.

**Key Distribution Center (KDC)**: A centralized service that shares a secret key with each host and helps establish secure channels between hosts.

**Multi-factor Authentication**: Multiple means of authentication are used together.

**Public-key Certificate**: Consists of a public key together with a string identifying the entity to which that key is associated, signed by a certification authority.

**Session Key**: A temporary shared secret key used during a single communication session between two parties.

**Single-factor Authentication**: Only one of four means of authentication is used (what you know, have, are, or do).

**Ticket**: A message encrypted with a secret key that can be used to prove identity and establish secure channels.

**Transport Layer Security (TLS)**: A protocol suite for setting up secure channels, commonly used to secure HTTP connections (HTTPS).

**Web of Trust**: Groups of people exchange their public keys and digitally sign each other's keys to establish ownership.

### Access Control
**Access Control List (ACL)**: Each object maintains a list of access rights of subjects that want to access the object.

**Access Control Matrix**: A model where subjects (rows) and objects (columns) are represented, with entries listing which operations each subject can perform on each object.

**Attribute-based Access Control (ABAC)**: Access control based on attributes of users, objects, environment, connections, and administrative settings.

**Capability**: A token that corresponds to an entry in the access control matrix, giving its holder certain rights.

**Delegation**: Passing certain access rights from one process to another to distribute work without affecting protection.

**Discretionary Access Control (DAC)**: The owner of an object is entitled to change access rights and who may have access.

**Mandatory Access Control (MAC)**: Access control policies decided by central administration beyond individual control.

**OAuth (Open Authorization)**: A delegation protocol for granting applications access to resources normally accessible to users through web interfaces.

**Proxy (in security context)**: A token that allows its owner to operate with the same or restricted rights as the subject that granted the token.

**Reference Monitor**: A program that records which subject may do what and decides whether a subject is allowed to have a specific operation carried out.

**Role-based Access Control (RBAC)**: Users are authorized based on their role within an organization rather than their identity.

### Trust and Attacks
**Eclipse Attack**: A collection of colluding nodes attempt to isolate a node from the network.

**Honest-but-curious Server**: A server that behaves according to protocol but may keep track of all the things it does.

**Sybil Attack**: An attack where an attacker creates multiple identities and joins a system separately with each identity to stage a specific attack.

**Trust Definition**: The assurance that one entity holds that another will perform particular actions according to a specific expectation.

**Trusted Computing Base (TCB)**: The set of all security mechanisms in a distributed computer system that are necessary and sufficient to enforce a security policy.

**Zero-day Attack**: Attacks based on vulnerabilities that have not yet been made public.

## 8. Performance and Metrics

### Performance Measurements
**Availability Formula**: A = MTTF / (MTTF + MTTR)

**Mean Time Between Failures (MTBF)**: MTTF + MTTR.

**Mean Time To Failure (MTTF)**: The average time until a component fails.

**Mean Time To Repair (MTTR)**: The average time needed to repair a component.

**Response Time**: How long it takes for a service to process a request, including queue time.

**Thread-level Parallelism (TLP)**: A metric measuring how effectively multiple threads put a multicore processor to work.

**Throughput**: The rate at which requests are processed.

**Utilization**: The fraction of time that a service is busy.

### Scalability and Optimization
**Administrative Scalability**: A system can still be easily managed even if it spans many independent administrative organizations.

**Caching**: Making a copy of a resource near the client accessing it (client-initiated replication).

**Geographical Scalability**: Users and resources may lie far apart, but communication delays are hardly noticed.

**Hiding Communication Latencies**: Using asynchronous communication and moving computation to clients.

**Partitioning and Distribution**: Splitting components into smaller parts and spreading them across the system.

**Scaling Out**: Expanding the system by deploying more machines.

**Scaling Up**: Improving capacity by upgrading hardware (memory, CPUs, network).

**Size Scalability**: A system can easily add more users and resources without any noticeable loss of performance.

## 9. Virtualization and Cloud Computing

### Virtualization Concepts
**Container**: A collection of binaries (images) that jointly constitute the software environment for running applications.

**Control Groups (cgroups)**: A mechanism by which resource restrictions can be imposed upon a collection of processes.

**Hosted Virtual Machine Monitor**: Runs on top of a trusted host operating system.

**Namespaces**: A mechanism by which a collection of processes associated with a container is given their own view of identifiers.

**Native Virtual Machine Monitor**: Implemented directly on top of the underlying hardware.

**Process Virtual Machine**: Virtualization that provides an abstract instruction set for executing applications, only for a single process.

**Resource Virtualization**: Extending or replacing an existing interface to mimic the behavior of another system.

**Union File System**: Allows combining several file systems in a layered fashion with only the highest layer allowing for write operations.

**Virtual Machine Monitor (VMM)**: A system implemented as a layer shielding the original hardware, but offering the complete instruction set.

### Cloud and Edge Computing
**Cloud Computing**: An easily usable and accessible pool of virtualized resources that can be dynamically configured, providing scalability on a pay-per-use model.

**Edge Computing**: Placement of services "at the edge" of the network, typically at the boundary between enterprise networks and the Internet.

**Fog Computing**: The term used for infrastructures between edge and cloud, often involving regional data centers.

**Function-as-a-Service (FaaS)**: Allows clients to execute code without managing servers.

**Infrastructure-as-a-Service (IaaS)**: Cloud service covering hardware and infrastructure layers.

**Mobile Cloud Computing (MCC)**: Mobile devices making use of remote cloud-based services.

**Mobile Edge Computing (MEC)**: Placing computational resources close to mobile devices to reduce latency.

**On-premise**: Services hosted on servers directly connected to the local network under local IT department responsibility.

**Platform-as-a-Service (PaaS)**: Cloud service covering the platform layer.

**Software-as-a-Service (SaaS)**: Cloud service covering applications.

**Utility Computing**: A model where customers upload tasks to a data center and are charged on a per-resource basis.

## 10. Specialized Systems and Technologies

### Blockchain and Distributed Ledgers
**Blockchain**: A distributed system that enables registration of transactions in a publicly available ledger without requiring a trusted third party.

**Distributed Ledger**: A system for registering transactions, with blockchain being one implementation approach.

**Immutable Block**: A block of transactions that is securely protected against any modifications.

**Leader Election**: A process in permissionless blockchains where nodes compete to be elected as the leader who appends a block to the chain.

**Permissioned Blockchain**: A blockchain where a small, preselected group of nodes validates transactions.

**Permissionless Blockchain**: A blockchain where all nodes collectively participate to validate transactions.

**Smart Contract**: Programs that are automatically executed when certain conditions are met within a blockchain block.

### Mobile and Pervasive Computing
**Context Awareness**: Using information to characterize the situation of entities relevant to user-application interaction.

**Implicit Action**: User action not primarily aimed at interacting with a computerized system but understood as input.

**Mobile Computing**: Computing with devices that change location over time, typically using wireless communication.

**Pervasive Systems**: Distributed systems intended to blend into our environment naturally with mobile and embedded devices.

**Ubiquitous Computing**: Pervasive system that is continuously present with highly unobtrusive interaction.

### Sensor Networks and IoT
**Abstract Regions**: Programming construct allowing a node to identify and interact with a neighborhood of nodes.

**In-Network Processing**: Processing and aggregating sensor data within the network rather than sending all raw data to a central location.

**Sensor Network**: Tens to thousands of small nodes equipped with sensing devices, often wireless and battery-powered.

### Web and Content Distribution
**Content Delivery Network (CDN)**: A distributed system using wide-area clusters to provide locality by offering data and services close to clients.

**Document Object Model (DOM)**: A tree representation of an HTML file used by web browsers.

**Edge Server**: A server that is part of a CDN, typically located closer to clients than the origin server.

**HyperText Markup Language (HTML)**: A markup language for web documents that includes instructions for displaying content.

**Origin Server**: The original server that hosts a website with all its documents in a CDN setup.

**Progressive Web Apps (PWA)**: Applications that use the browser as their hosting environment yet appear as ordinary mobile apps.

**Render Tree**: The DOM with styling information added, containing all information for determining layout.

**Uniform Resource Locator (URL)**: A reference specifying where a document is located by embedding the DNS name of its associated server along with a file name.

**Web Proxy**: A server that accepts requests from local clients, passes them to Web servers, and can cache results for sharing among multiple clients.

## 11. Processes and Threading

### Process Management
**Process**: A program in execution, generally defined from an operating-system perspective as a program that is currently being executed on one of the operating system's virtual processors.

**Process Context**: The software analog of the hardware's processor context, containing CPU register values, memory maps, open files, accounting information, privileges, etc.

**Processor Context**: The minimal information that is automatically stored by the hardware to handle an interrupt, and to later return to where the CPU left off.

### Threading Models
**Many-to-many Threading Model**: A hybrid form of user-level and kernel-level threads where multiple user threads are mapped to multiple kernel threads.

**Many-to-one Threading Model**: Multiple threads are mapped to a single schedulable entity.

**One-to-one Threading Model**: Every thread is a schedulable entity, where every thread operation requires a system call.

**Thread**: Executes its own piece of code, independently of other threads. In contrast to processes, no attempt is made to achieve a high degree of concurrency transparency if this would result in performance degradation.

**Thread Context**: Generally consists of nothing more than the processor context, along with some other information for thread management.

### Code Migration
**Code Migration**: Moving programs between machines with the intention to have those programs be executed at the target.

**Code Segment**: The part that contains the set of instructions that make up the program being executed.

**Execution Segment**: Used to store the current execution state of a process (private data, stack, program counter).

**Federated Learning**: A machine learning approach where partially trained models are brought to where the data is for local training.

**Mobile Agent**: A small mobile program that moves from site to site, often used for searching information or exploiting parallelism.

**Process Migration**: Moving an entire process from one node to another.

**Receiver-initiated Migration**: The initiative for code migration is taken by the target machine.

**Remote Cloning**: Yields an exact copy of the original process running on a different machine, executed in parallel to the original process.

**Resource Segment**: Contains references to external resources needed by the process (files, printers, devices, other processes).

**Sender-initiated Migration**: Migration initiated at the machine where the code currently resides or is being executed.

**Strong Mobility**: The execution segment can be transferred as well. A running process can be stopped, moved to another machine, and resume execution exactly where it left off.

**Weak Mobility**: The ability to transfer only the code segment, along with perhaps some initialization data. Transferred programs always start anew.

## 12. Transaction Processing

### ACID Properties and Transactions
**ACID Properties**:
- **Atomic**: Transaction happens indivisibly
- **Consistent**: Does not violate system invariants
- **Isolated**: Concurrent transactions don't interfere
- **Durable**: Once committed, changes are permanent

**Distributed Commit**: Having operation performed by each member of process group, or none at all.

**Nested Transaction**: Top-level transaction that forks off children running in parallel.

**One-phase Commit**: Coordinator tells participants whether to perform operation.

**Transaction**: A collection of operations that either all execute or none execute (atomic).

**Transaction Processing Monitor (TP Monitor)**: Component that coordinates distributed transactions using distributed commit protocols.

### Integration and Middleware
**Broker**: A logically centralized component that handles all accesses between different applications, reducing the number of required wrappers from O(N²) to O(N).

**Enterprise Application Integration (EAI)**: Letting applications communicate directly with each other rather than just through databases.

**File Transfer**: Applications share data by producing files that other applications read.

**Interceptor**: A software construct that breaks the usual flow of control and allows other application-specific code to be executed.

**Messaging**: Asynchronous message passing between applications.

**Middleware**: A software layer that provides common services above the operating system but below applications.

**Modifiable Middleware**: Middleware that can be adapted and modified without bringing the system down, supporting dynamic changes.

**Shared Database**: Multiple applications access the same database.

**Wrapper/Adapter**: A special component that offers an interface acceptable to a client application, transforming functions into those available at the component.

## 13. Networking and Communication Patterns

### Network Types and Topologies
**Content Delivery Networks (CDNs)**: Distributed collection of servers that cache and serve web content from locations close to users.

**Local-Area Networks (LANs)**: Allow thousands of machines within a building to be connected for fast data transfer.

**Mobile Ad Hoc Networks (MANETs)**: Group of mobile computers that jointly set up a local wireless network.

**Overlay Network**: A network where nodes are formed by processes and links represent possible communication channels.

**Wide-Area Networks (WANs)**: Allow hundreds of millions of machines globally to be connected at varying speeds.

### Multicast and Epidemic Protocols
**Anti-entropy**: A propagation model where nodes exchange updates by pulling, pushing, or push-pull approaches.

**Application-level Multicasting**: Organizing nodes into an overlay network to disseminate information to members.

**Death Certificates**: Records of data item deletions that are spread to prevent old copies from being interpreted as new updates.

**Directional Gossiping**: Epidemic protocols that take network topology into account, contacting bridge nodes with higher probability.

**Epidemic Protocols**: Protocols based on disease-spreading models for information dissemination in distributed systems.

**Flooding**: A naive multicasting approach where each node forwards messages to all neighbors except the sender.

**Infected Node**: A node that holds data it is willing to spread to other nodes.

**Link Stress**: A metric counting how often a packet crosses the same physical link in an overlay.

**Multicast Communication**: Sending data to multiple receivers.

**Probabilistic Flooding**: A flooding variant where nodes forward messages with a certain probability to reduce message overhead.

**Removed Node**: An updated node that is not willing or able to spread its data.

**Rumor Spreading**: An epidemic protocol variant where nodes may lose interest in spreading updates after contacting already-updated nodes.

**Susceptible Node**: A node that has not yet seen the data being spread.

**Tree Cost**: A global metric related to minimizing aggregated link costs in a multicast tree.

## 14. System Transparency and Quality Attributes

### Transparency Types
**Access Transparency**: Hide differences in data representation and how an object is accessed.

**Concurrency Transparency**: Hiding that a resource may be shared by several independent users.

**Distribution Transparency**: Hiding the fact that processes and resources are physically distributed across multiple computers from end users and applications.

**Failure Transparency**: Hiding that some piece of the system fails to work properly and that the system subsequently recovers from that failure.

**Location Transparency**: Users cannot tell where an object is physically located in the system.

**Migration Transparency**: Supporting mobility of processes and resources initiated by users, without affecting ongoing communication and operations.

**Relocation Transparency**: Hiding that an object may be moved to another location while in use.

**Replication Transparency**: Hiding the fact that several copies of a resource exist.

### System Quality Attributes
**Extensibility**: Ease of adding new components or replacing existing ones.

**Idempotent Operation**: An operation that can be repeated multiple times without harm.

**Interoperability**: Extent to which implementations from different manufacturers can work together.

**Policy vs Mechanism Separation**: Separating what should be done (policy) from how it's done (mechanism).

**Portability**: Extent to which an application can run without modification on different systems.

**Stateless Execution**: A property where a component forgets everything about the caller after executing an operation.

## 15. Specialized Data Structures and Algorithms

### Data Structures
**Bloom Filter**: A space-efficient probabilistic data structure used to test whether an element is a member of a set.

**Linda Tuple Space**: A shared data space supporting three operations: in(t) to remove matching tuples, rd(t) to copy matching tuples, and out(t) to add tuples.

**Shared Data Space**: Referentially and temporally decoupled processes communicating entirely through tuples in a shared space.

**Tuples**: Structured data records consisting of several fields, similar to database table rows.

### Specialized Algorithms and Protocols
**Compiling**: The process of transforming a computer program written in a given language into a set of instructions in another format or language.

**Free Riding**: A phenomenon where participants download files but contribute little to nothing back to the system.

**Hilbert Space-Filling Curve**: A specific type of space-filling curve that preserves locality, ensuring points close on the curve correspond to points close in multidimensional space.

**Magnet Link**: Used in DHT-based BitTorrent systems to look up the initial tracker for a requested file.

**Random Walk**: A search method where a request is forwarded to randomly chosen neighbors until the data is found.

**Space-Filling Curve**: A technique that maps an N-dimensional space covered by N attributes into a single dimension for distribution among index servers.

**Time-to-Live (TTL)**: The maximum number of hops a request is allowed to be forwarded.

**Torrent File**: Contains information needed to download a specific file, including a link to a tracker.

**Tracker**: In BitTorrent, a server that keeps an accurate account of active nodes that have chunks of a requested file.

**Triangle Inequality**: The geometric principle that d(P,R) ≤ d(P,Q) + d(Q,R) for any three points.

## 16. System Architecture Layers and Patterns

### Grid and Layered Architectures
**Application Layer**: Applications that operate within a virtual organization.

**Collective Layer**: Handles access to multiple resources (discovery, allocation, scheduling).

**Connectivity Layer**: Communication protocols for grid transactions spanning multiple resources.

**Fabric Layer**: Provides interfaces to local resources at a specific site.

**Grid Computing**: Decentralized systems constructed as federation of different computer systems from different administrative domains.

**Resource Layer**: Manages a single resource using connectivity layer functions.

**Virtual Organization**: A collaboration of people from different institutions with shared access rights to federated resources.

### Memory and Computing Models
**Distributed Shared Memory (DSM)**: Allows a processor to address memory at another computer as if it were local.

**Multicomputer**: Several computers connected through a network with no sharing of main memory.

**Multiprocessor**: Multiple CPUs with access to the same physical memory.

### System Classifications
**Asynchronous System**: No assumptions about process execution speeds or message delivery times are made.

**Partially Synchronous System**: Most of the time behaves as synchronous, but there's no bound on time it behaves asynchronously.

**Synchronous System**: Process execution speeds and message-delivery times are bounded.

---

## Appendix: Common Design Principles and Fallacies

### Deutsch's Fallacies
Common incorrect assumptions when developing distributed applications:
1. The network is reliable
2. The network is secure
3. The network is homogeneous
4. The topology does not change
5. Latency is zero
6. Bandwidth is infinite
7. Transport cost is zero
8. There is one administrator

### Security Design Principles
1. **Complete Mediation**: Every access to every object must be checked when it comes to whether it is allowed.
2. **Fail-safe Defaults**: Assuming that any set of defaults will generally not be changed; defaults should already guarantee a good degree of protection.
3. **Least Common Mechanism**: If multiple components require the same mechanism, they should all be offered the same implementation of that mechanism.
4. **Least Privilege**: A process should operate with the fewest possible privileges.
5. **Open Design**: Not applying security by obscurity; every aspect of a distributed system should be open for review.
6. **Psychological Acceptability**: Building appropriate user interfaces so that people can do only the right thing.
7. **Separation of Privilege**: Ensuring that truly critical aspects of a system can never be fully controlled by just a single entity.
