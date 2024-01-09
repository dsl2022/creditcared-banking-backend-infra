'use strict';

module.exports.handler = async (event) => {
  console.log("Stream record: ", JSON.stringify(event, null, 2));

  event.Records.forEach((record) => {
      console.log('Stream record: ', JSON.stringify(record, null, 2));

      if (record.eventName == 'INSERT') {
          const newImage = record.dynamodb.NewImage;
          console.log('New item added:', JSON.stringify(newImage, null, 2));
      } else if (record.eventName == 'MODIFY') {
          const oldImage = record.dynamodb.OldImage;
          const newImage = record.dynamodb.NewImage;
          console.log('Item modification detected:');
          console.log('Old item:', JSON.stringify(oldImage, null, 2));
          console.log('New item:', JSON.stringify(newImage, null, 2));
      } else if (record.eventName == 'REMOVE') {
          const oldImage = record.dynamodb.OldImage;
          console.log('Item removed:', JSON.stringify(oldImage, null, 2));
      }
  });
  return `Successfully processed ${event.Records.length} records.`;
};