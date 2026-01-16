batch_query = """query GetBatch($id: Int!) {
    Batch(id: $id) {
      id
      scenario {
        id
        name
        parameters {
          id
          max
          min
          name
          unit
        }
        testObjectives {
          criticalityMetrics {
            id
            threshold
            keyPerformanceIndicator {
              id
              name
              rule
              unit
            }
          }
        }
      }
    }
}
"""

trials_query = """
    query GetTrials(
        $limit: Int
        $sort: String
        $where: Trial_where
        $page: Int
    ) {
        Trials(limit: $limit, sort: $sort, where: $where, page: $page) {
  	        docs {
                id
                ego {
                    id
                    name
                }
                parameters {
                    parameterId
                    value
                }
                testObjectives {
                    criticalityMetrics {
                        value
                        passed
                        keyPerformanceIndicator {
                            id
                            name
                        }
                    }
                }
            }
        }
    }
"""
