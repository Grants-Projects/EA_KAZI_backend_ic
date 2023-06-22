import shared "ic:canister/agent";
import storage "ic:canister/storage";

// Define the remuneration and certification canister
actor RemunerationCertification {

  // Remuneration details
  type Remuneration = {
    user: Principal,
    amount: Nat,
    currency: Text
  };

  // Certification details
  type Certification = {
    user: Principal,
    certificate: Text,
    expiration: Time
  };

  // Remuneration and certification storage
  stable var remunerations : [Remuneration] = [];
  stable var certifications : [Certification] = [];

  // Function to add a remuneration record
  public func addRemuneration(user : Principal, amount : Nat, currency : Text) : async {
    let remuneration : Remuneration = { user = user, amount = amount, currency = currency };
    remunerations := remuneration :: remunerations;
  }

  // Function to add a certification record
  public func addCertification(user : Principal, certificate : Text, expiration : Time) : async {
    let certification : Certification = { user = user, certificate = certificate, expiration = expiration };
    certifications := certification :: certifications;
  }

  // Function to get all remunerations
  public query func getAllRemunerations() : async [Remuneration] {
    return remunerations;
  }

  // Function to get all certifications
  public query func getAllCertifications() : async [Certification] {
    return certifications;
  }

}

// Export the canister's functions to the Internet Computer
export service {
  public {
    addRemuneration : (Principal, Nat, Text) -> async ();
    addCertification : (Principal, Text, Time) -> async ();
    getAllRemunerations : () -> async [Remuneration];
    getAllCertifications : () -> async [Certification];
  }
}
