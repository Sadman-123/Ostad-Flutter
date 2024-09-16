# Blog App

This is a Flutter-based **Cupertino App** named **Blog**. The app provides a user-friendly interface for managing blog posts, including operations for Create, Read, Update, and Delete.

## Features
- **Create** a blog post (Screenshot: s3.png)
- **Read** existing blog posts (Screenshots: s1.png, s2.png)
- **Update** a blog post (Screenshot: s5.png)
- **Delete** a blog post (Screenshot: s6.png)

## API Integration

The Blog App integrates with a RESTful API built with Express.js and MongoDB, hosted on Vercel. This API handles the CRUD operations for blog posts.

### API Endpoints

- **Create Blog Post**: `POST /https://tasker26.vercel.app/upload`
- **Read Blog Posts**: `GET /https://tasker26.vercel.app/api`
- **Update Blog Post**: `PUT /https://tasker26.vercel.app/update/:id`
- **Delete Blog Post**: `DELETE /https://tasker26.vercel.app/delete/:id`

### Testing the API

You can test the API using the Postman collection provided below:

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://god.gw.postman.com/run-collection/38050242-c0ec2cfc-a181-437a-a6b9-84d26aa991e6?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D38050242-c0ec2cfc-a181-437a-a6b9-84d26aa991e6%26entityType%3Dcollection%26workspaceId%3D491054b4-8867-4375-b568-d295e9a4e1b0)

## Screenshots

### Read Operation
| Screenshot 1 | Screenshot 2 |
| ------------ | ------------ |
| ![s1](SS/s1.png) | ![s2](SS/s2.png) |

### Create Operation
| Screenshot 3 |
| ------------ |
| ![s3](SS/s3.png) |

### Update Operation
| Screenshot 5 |
| ------------ |
| ![s5](SS/s5.png) |

### Delete Operation
| Screenshot 6 |
| ------------ |
| ![s6](SS/s6.png) |


## Demo Video

[![Blog App Demo](https://img.youtube.com/vi/WUBMcHZ4rFQ/maxresdefault.jpg)](https://www.youtube.com/watch?v=WUBMcHZ4rFQ)
