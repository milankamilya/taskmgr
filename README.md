# Question:
Build an app to maintain and track tasks, also allow for due dates for time sensitive tasks to be synced to the system calendar via content provider.  Include the ability for notifications to be displayed to the user regarding upcoming tasks for the day.

# Solution:
I have used MVVM-Coordinator (or Router) architecture to solve it. As this architecture is easy to testable, maintainable & separate concerns/responsibility of each items. The Coordinator abstract the navigation information from view controller, so navigation throughout the code becomes easy.