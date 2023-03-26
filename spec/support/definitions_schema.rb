# This file defines schemas for swagger documentation.
# The schemas are used to validate the structure and properties of the objects and to provide examples in the documentation.
# Usage: used in the swagger_helper.rb file to define the structure of the objects in the components section.

USER_SCHEMA = {
  type: :object,
  required: %i[id type attributes],
  properties: {
    id: { type: :string, example: '1' },
    type: { type: :string, example: 'user' },
    attributes: {
      type: :object,
      required: %i[id name created_at updated_at],
      properties: {
        id: { type: :integer, example: 1 },
        name: { type: :string, example: 'Fr. Shalonda Pfannerstill' },
        created_at: { type: :string, format: :'date-time', example: '2023-03-24T19:17:35.563Z' },
        updated_at: { type: :string, format: :'date-time', example: '2023-03-24T19:17:35.563Z' }
      }
    }
  }
}

SLEEP_RECORDS_SCHEMA = {
  type: :object,
  required: %i[id type attributes relationships],
  properties: {
    id: { type: :string, example: '5' },
    type: { type: :string, example: 'sleep_record' },
    attributes: {
      type: :object,
      properties: {
        id: { type: :integer, example: 5 },
        start_time: { type: :string, format: :datetime, example: '2023-03-22T19:00:00.000Z' },
        end_time: { type: :string, format: :datetime, example: '2023-03-23T19:00:00.000Z' },
        sleep_length_in_minutes: { type: :number, example: 1440.0 },
        created_at: { type: :string, format: :datetime, example: '2023-03-26T16:07:00.390Z' },
        updated_at: { type: :string, format: :datetime, example: '2023-03-26T16:07:00.390Z' }
      }
    },
    relationships: {
      type: :object,
      properties: {
        user: {
          type: :object,
          properties: {
            data: {
              type: :object,
              required: %i[id type],
              properties: {
                id: { type: :string, example: '2' },
                type: { type: :string, example: 'user' }
              }
            }
          }
        }
      }
    }
  }
}

FRIENDSHIP_SCHEMA = {
  type: :object,
  required: %i[id type attributes relationships],
  properties: {
    id: { type: :string, example: '7' },
    type: { type: :string, example: 'friendship' },
    attributes: {
      type: :object,
      required: %i[id created_at updated_at],
      properties: {
        id: { type: :integer, example: 7 },
        created_at: { type: :string, format: :'date-time', example: '2023-03-26T16:21:19.892Z' },
        updated_at: { type: :string, format: :'date-time', example: '2023-03-26T16:21:19.892Z' }
      }
    },
    relationships: {
      type: :object,
      required: %i[user friend],
      properties: {
        user: {
          type: :object,
          required: %i[data],
          properties: {
            data: {
              type: :object,
              required: %i[id type],
              properties: {
                id: { type: :string, example: '1' },
                type: { type: :string, example: 'user' }
              }
            }
          }
        },
        friend: {
          type: :object,
          required: %i[data],
          properties: {
            data: {
              type: :object,
              required: %i[id type],
              properties: {
                id: { type: :string, example: '7' },
                type: { type: :string, example: 'user' }
              }
            }
          }
        }
      }
    }
  }
}
