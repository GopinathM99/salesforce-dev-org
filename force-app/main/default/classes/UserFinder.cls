public class UserFinder {
    public static List<User> findUsers(String profileName, String roleName, String permissionSetName) {
        // Query to get the Id of the Profile
        Profile profile = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];

        // Query to get the Id of the Role
        UserRole role = [SELECT Id FROM UserRole WHERE Name = :roleName LIMIT 1];

        // Query to get the Ids of Users with the specified Profile and Role
        List<User> usersWithProfileAndRole = [
            SELECT Id, Name 
            FROM User 
            WHERE ProfileId = :profile.Id 
            AND UserRoleId = :role.Id
        ];

        // Query to get the Ids of Users who have the specified Permission Set assigned
        Set<Id> usersWithPermissionSet = new Set<Id>();
        for(PermissionSetAssignment psa : [
            SELECT AssigneeId 
            FROM PermissionSetAssignment 
            WHERE PermissionSet.Name = :permissionSetName
        ]) {
            usersWithPermissionSet.add(psa.AssigneeId);
        }

        // Filter out users who have the Permission Set
        List<User> filteredUsers = new List<User>();
        for (User user : usersWithProfileAndRole) {
            if (!usersWithPermissionSet.contains(user.Id)) {
                filteredUsers.add(user);
            }
        }

        return filteredUsers;
    }
}
