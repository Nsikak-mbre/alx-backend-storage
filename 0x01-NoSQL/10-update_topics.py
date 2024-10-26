#!/usr/bin/env python3
"""
Module to update topics of a school document based on the name.
"""

def update_topics(mongo_collection, name, topics):
    """
    Update all topics of a school document based on the name.
    
    Args:
        mongo_collection: pymongo collection object
        name (str): School name to update
        topics (list): List of topic strings to update
        
    Returns:
        ModifyResult: Result of the update operation
    """
    if topics is None:
        topics = []
        
    return mongo_collection.update_many(
        { "name": name },
        { "$set": { "topics": topics } },
        upsert=False
    )

if __name__ == "__main__":
    pass
