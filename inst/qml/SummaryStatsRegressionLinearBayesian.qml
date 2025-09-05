//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick
import QtQuick.Layouts
import JASP.Controls
import JASP

Form
{
	info: qsTr("Bayesian Linear regression allows you to model a linear relationship between one or more explanatory variable(s) (predictors) and a continuous dependent (response) variable. This analysis, based on the classical (unadjusted) R^2 statistic, allows you to compute the corresponding Bayes factor test. The Bayes factor is computed using Gaussian quadrature.")

	IntegerField { label: qsTr("Sample size"); name: "sampleSize" ; min: 3; Layout.columnSpan: 2; defaultValue: 3}

	Group
	{
		title: qsTr("Null Model")
		IntegerField {	label: qsTr("Number of covariates"); name: "nullNumberOfCovariates" }; info: qsTr("Number of predictors in the null model (excluding intercept).")
		DoubleField {	label: qsTr("R-squared");			name: "nullUnadjustedRSquared" ; max: 0.9999; info: qsTr("Proportion of variance accounted by the predictors.") }
	}

	Group
	{
		title: qsTr("Alternative Model")
		IntegerField {	label: qsTr("Number of covariates"); name: "alternativeNumberOfCovariates" ; min: 1; defaultValue: 1; info: qsTr("Number of predictors in the alternative model (excluding intercept).") }
		DoubleField {	label: qsTr("R-squared");			name: "alternativeUnadjustedRSquared" ; max: 0.9999; info: qsTr("Proportion of variance accounted by the predictors.")}
	}

	Divider { }

	BayesFactorType { }

	Group
	{
		title: qsTr("Plots")
		CheckBox
		{
			name: "bfRobustnessPlot"; label: qsTr("Bayes factor robustness check"); info: qsTr("Displays the Bayes factor as a function of the width of the Cauchy prior on effect size. The scale of the Cauchy prior is varied between 0 and 1.5 (between 0 and 2 if user prior width is greater than 1.5), creating progressively more uninformative priors.")
			CheckBox { name: "bfRobustnessPlotAdditionalInfo"; label: qsTr("Additional info"); checked: true; info: qsTr("Displays the maximum Bayes factor in favor of the alternative hypothesis and the user Bayes factor.") }
		}
	}

    Section
	{
        title: qsTr("Advanced Options")

        Group
		{
            title: qsTr("Prior")
			DoubleField { label: qsTr("r scale covariates"); defaultValue: 0.354 ; name: "priorRScale" ; fieldWidth: 80; max: 2; inclusive: JASP.MaxOnly; decimals: 3 }
        }
    }
}
