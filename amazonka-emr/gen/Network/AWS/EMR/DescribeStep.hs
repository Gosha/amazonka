{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE StandaloneDeriving          #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.EMR.DescribeStep
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Provides more detail about the cluster step.
module Network.AWS.EMR.DescribeStep
    (
    -- * Request
      DescribeStep
    -- ** Request constructor
    , describeStep
    -- ** Request lenses
    , dsClusterId
    , dsStepId

    -- * Response
    , DescribeStepResponse
    -- ** Response constructor
    , describeStepResponse
    -- ** Response lenses
    , dsrStep
    ) where

import Network.AWS.EMR.Types
import Network.AWS.Prelude
import Network.AWS.Request.JSON

-- | This input determines which step to describe.
data DescribeStep = DescribeStep
    { _dsClusterId :: Text
    , _dsStepId :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'DescribeStep' request.
--
-- The fields accessible through corresponding lenses are:
--
-- * @ClusterId ::@ @Text@
--
-- * @StepId ::@ @Text@
--
describeStep :: Text -- ^ 'dsClusterId'
             -> Text -- ^ 'dsStepId'
             -> DescribeStep
describeStep p1 p2 = DescribeStep
    { _dsClusterId = p1
    , _dsStepId = p2
    }

-- | The identifier of the cluster with steps to describe.
dsClusterId :: Lens' DescribeStep Text
dsClusterId = lens _dsClusterId (\s a -> s { _dsClusterId = a })

-- | The identifier of the step to describe.
dsStepId :: Lens' DescribeStep Text
dsStepId = lens _dsStepId (\s a -> s { _dsStepId = a })

instance ToPath DescribeStep

instance ToQuery DescribeStep

instance ToHeaders DescribeStep

instance ToJSON DescribeStep

-- | This output contains the description of the cluster step.
newtype DescribeStepResponse = DescribeStepResponse
    { _dsrStep :: Maybe Step
    } deriving (Eq, Ord, Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'DescribeStepResponse' response.
--
-- This constructor is provided for convenience and testing purposes.
--
-- The fields accessible through corresponding lenses are:
--
-- * @Step ::@ @Maybe Step@
--
describeStepResponse :: DescribeStepResponse
describeStepResponse = DescribeStepResponse
    { _dsrStep = Nothing
    }

-- | The step details for the requested step identifier.
dsrStep :: Lens' DescribeStepResponse (Maybe Step)
dsrStep = lens _dsrStep (\s a -> s { _dsrStep = a })

instance FromJSON DescribeStepResponse

instance AWSRequest DescribeStep where
    type Sv DescribeStep = EMR
    type Rs DescribeStep = DescribeStepResponse

    request = get
    response _ = jsonResponse
