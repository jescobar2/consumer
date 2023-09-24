# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM python:3.9-slim as builder

WORKDIR /app

# Copy your Python source code and any necessary files
COPY app.py requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Build a standalone Python application (if needed)

# Switch to a non-root user
RUN useradd -m nonroot
USER nonroot

# Set environment variables, if necessary
# ENV VARIABLE_NAME=value
ENV PORT 8081
# Define the command to run your application
CMD ["python", "app.py"]