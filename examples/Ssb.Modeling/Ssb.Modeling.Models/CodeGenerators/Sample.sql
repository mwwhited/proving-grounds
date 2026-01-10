/* Service Broker Creation Script for "Project1" */

/* XML Schema Collections */
CREATE XML SCHEMA COLLECTION [dbo].[XmlSchemaCollection1] AS N'
      <xs:schema id=''XMLSchema1''
    targetNamespace=''http://tempuri.org/XMLSchema1.xsd''
    elementFormDefault=''qualified''
    xmlns=''http://tempuri.org/XMLSchema1.xsd''
    xmlns:xs=''http://www.w3.org/2001/XMLSchema''
>
</xs:schema>
    ';

/* Message Types */
CREATE MESSAGE TYPE [MessageType1]
  /*[ AUTHORIZATION owner_name ]*/
  VALIDATION = VALID_XML WITH SCHEMA COLLECTION [dbo].[XmlSchemaCollection1];

/* Contracts */
CREATE CONTRACT [Contract1]
  /*[ AUTHORIZATION owner_name ]*/
  (
    [MessageType1] SEND BY ANY
  );

/* Queues */
CREATE QUEUE [dbo].[Queue1]
  WITH
    STATUS = ON,
    RETENTION = OFF,
    POISON_MESSAGE_HANDLING (
      STATUS = OFF
    ),
    ACTIVATION (
      STATUS = OFF,
      PROCEDURE_NAME = [dbo].[sp_Handler1],
      MAX_QUEUE_READERS = 10,
      EXECUTE AS SELF /*{ SELF | 'user_name' | OWNER }*/
    )
    /* [ ON { filegroup | [ DEFAULT ] } ] */
  ;

CREATE QUEUE [dbo].[Queue2]
  WITH
    STATUS = ON,
    RETENTION = OFF,
    POISON_MESSAGE_HANDLING (
      STATUS = OFF
    )
    /* [ ON { filegroup | [ DEFAULT ] } ] */
  ;

/* Services */
CREATE SERVICE [Service1]
  ON QUEUE [dbo].[Queue1]
  (
    [Contract1]
  );
