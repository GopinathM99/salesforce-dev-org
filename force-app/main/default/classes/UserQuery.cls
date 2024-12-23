public with sharing class UserQuery {
    public UserQuery() {

    }

        /**
     * Fetches users with the specified profile name, role name, and permission set.
     * 
     * @param profileName The name of the profile to filter by.
     * @param roleName The name of the role to filter by.
     * @param permissionSetName The name of the permission set to check for.
     * @return A list of User records matching all criteria.
     */
    public static List<User> getUsersByProfileRoleAndPermissionSet(String profileName, String roleName, String permissionSetName) {
        // Get Profile Id
        Profile p = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];
        
        // Get UserRole Id
        UserRole r = [SELECT Id FROM UserRole WHERE Name = :roleName LIMIT 1];
        
        // Get PermissionSet Id
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName LIMIT 1];

        if(p == null || r == null || ps == null) {
            System.debug('Profile, Role, or Permission Set not found');
            return new List<User>();
        }

        // Query for PermissionSetAssignment to get users with the specific permission set
        Set<Id> userIdsWithPermissionSet = new Set<Id>();
        for(PermissionSetAssignment psa : [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId = :ps.Id]) {
            userIdsWithPermissionSet.add(psa.AssigneeId);
        }

        // Now, query for users with both the profile, role, and who are in our set of users with the permission set
        List<User> users = [
            SELECT Id, Name, Username, Email, Profile.Name, UserRole.Name 
            FROM User 
            WHERE ProfileId = :p.Id 
            AND UserRoleId = :r.Id
            AND Id IN :userIdsWithPermissionSet
        ];

        return users;
    }

    // Example method to demonstrate usage
    public static void demonstrateUsage() {
        List<User> specificUsers = getUsersByProfileRoleAndPermissionSet('Standard User', 'Sales Manager', 'Advanced_Sales_Features');
        for(User u : specificUsers) {
            System.debug('User: ' + u.Name + ', Email: ' + u.Email);
        }
    }
}
