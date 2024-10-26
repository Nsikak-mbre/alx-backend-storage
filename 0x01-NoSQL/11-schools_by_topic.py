#!/usr/bin/env python3
"""
Module to return list of schools having a specific topic.
"""

def schools_by_topic(mongo_collection, topic):
    """
    Return the list of schools having a specific topic.
    """
    schools = []
    query = { "topics": topic }
    for school in mongo_collection.find(query):
        schools.append(school)
    return schools

if __name__ == "__main__":
    pass  # This block ensures the script doesn't run when imported
